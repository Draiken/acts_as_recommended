require 'spec_helper'

describe ActsAsRecommended do

  before(:all) do
    Post.destroy_all
    User.destroy_all

    Post.acts_as_recommended
    @post = Post.new(:title => "Test")
    @post.save
    @user = User.new(:name => "Bob")
    @user.save
  end

  it "should be a module" do
    ActsAsRecommended.should be_a(Module)
  end

  it "should add a recommendation" do
    @post.recommend! true, @user

    @post.recommendations.should == 1
    @post.good_recommendations.should == 1
    @post.bad_recommendations.should == 0
    @post.bad_recommendations_percent.should == "0.00"
    @post.good_recommendations_percent.should == "100.00"
  end

  it "should raise an error when adding a nil recommendation " do
    lambda { @post.recommend! nil, @user }.should raise_error
  end

  it "should change a recommendation" do
    user = User.new(:name => 'John')
    user.save
    @post.recommend! true, user
    @post.recommend! true, @user

    recommendations_tests(2, 0)

    @post.recommend! false, user

    recommendations_tests(1, 1)

    @post.recommend! true, user

    recommendations_tests(2, 0)
  end

  it "should get the recommendation of an user" do
    lulu = User.new(:name => 'Lulu')
    lulu.save

    @post.recommend! true, lulu
    recommendation = @post.get_recommendation_of lulu
    recommendation.should be_true
  end

  private

  def recommendations_tests(good, bad)
    total = good + bad
    @post.recommendations.should == (good - bad)
    @post.good_recommendations.should == good
    @post.bad_recommendations.should == bad
    @post.bad_recommendations_percent.should == "%.2f" % (bad.to_f / (total == 0 ? 1.to_f : (total.to_f)) * 100)
    @post.good_recommendations_percent.should == "%.2f" % (good.to_f / (total == 0 ? 1.to_f : (total.to_f)) * 100)
  end
end

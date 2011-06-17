class AddRecommendationsToPosts < ActiveRecord::Migration
  def self.up
    add_column :posts, :good_recommendations, :integer, :default => 0
    add_column :posts, :bad_recommendations, :integer, :default => 0
  end

  def self.down
    remove_column :posts, :good_recommendations
    remove_column :posts, :bad_recommendations
  end
end

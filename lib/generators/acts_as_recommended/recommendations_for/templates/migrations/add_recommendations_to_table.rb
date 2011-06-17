class AddRecommendationsTo<%= table_name.camelize %> < ActiveRecord::Migration
  def self.up
    add_column :<%= table_name %>, :good_recommendations, :integer, :default => 0
    add_column :<%= table_name %>, :bad_recommendations, :integer, :default => 0
  end

  def self.down
    remove_column :<%= table_name %>, :good_recommendations
    remove_column :<%= table_name %>, :bad_recommendations
  end
end

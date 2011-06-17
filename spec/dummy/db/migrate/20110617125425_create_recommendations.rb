class CreateRecommendations < ActiveRecord::Migration
  def self.up
    create_table :recommendations do |t|
      t.references :recommendable, :polymorphic => true, :null => false
      t.references :owner, :null => false
      t.boolean    :recommendation, :null => false
      
      t.timestamps
    end
    
    add_index :recommendations, [:recommendable_type, :recommendable_id],  :name => 'idx_recommendations'
    add_index :recommendations, [:recommendable_type, :recommendable_id, :owner_id], :unique => true, :name => 'idx_recommendations_user'
    add_index :recommendations, [:recommendable_type, :recommendable_id, :recommendation],  :name => 'idx_recommendations_type'
  end

  def self.down
    drop_table :recommendations
  end
end

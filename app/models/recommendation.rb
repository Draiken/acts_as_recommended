class Recommendation < ActiveRecord::Base
  
  belongs_to :owner, :class_name => ActsAsRecommended.owner_class
  belongs_to :recommendable, :polymorphic => true

  scope :of_item, lambda { |item| where('recommendable_id = ?', item.id).where('recommendable_type = ?', item.class.base_class.name.to_s) }
  scope :owned_by, lambda { |owner| where('owner_id = ?', owner.id) }
  
end

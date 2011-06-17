module ActsAsRecommended

  mattr_accessor :owner_class
  @@owner_class = :user

end

require 'acts_as_recommended/engine'

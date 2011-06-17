module ActsAsRecommended
  class Engine < ::Rails::Engine
    initializer :acts_as_recommended do |app|
      ActiveSupport.on_load(:active_record) do
        require File.join(File.dirname(__FILE__), 'model_extensions')
        ::ActiveRecord::Base.send :include, ActsAsRecommended::ModelExtensions
      end
    end
  
  end
end

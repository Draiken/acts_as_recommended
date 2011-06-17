require 'rails/generators'
require 'rails/generators/migration'

module ActsAsRecommended
  module Generators
    class TablesGenerator < Rails::Generators::Base
      include Rails::Generators::Migration

      def self.source_root
        File.expand_path(File.join(File.dirname(__FILE__), 'templates'))
      end

      def self.next_migration_number(dirname)
        if ActiveRecord::Base.timestamped_migrations
          Time.now.utc.strftime("%Y%m%d%H%M%S")
        else
          "%.3d" % (current_migration_number(dirname) + 1)
        end
      end

      def manifest
        migration_template "migrations/create_recommendations.rb", "db/migrate/create_recommendations"
      end
    end
  end
end

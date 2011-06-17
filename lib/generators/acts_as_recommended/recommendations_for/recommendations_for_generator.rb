require 'rails/generators'
require 'rails/generators/migration'

module ActsAsRecommended
  module Generators
    class RecommendationsForGenerator < Rails::Generators::NamedBase
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
        migration_template "migrations/add_recommendations_to_table.rb", "db/migrate/add_recommendations_to_#{table_name}", {:assigns => {:name => name, :table_name => table_name}}
      end
    end
  end
end

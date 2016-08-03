require 'rails/generators'
require 'rails/generators/active_record'

class GrapeDbLoggerGenerator < ActiveRecord::Generators::Base
  argument :name, type: :string, default: 'random_name'

  class_option :'skip-migration', type: :boolean, desc: "Don't generate a migration for the logs table"

  source_root File.expand_path('../../grape_db_logger', __FILE__)

  def copy_files
    return if options['skip-migration']
    migration_template 'migration.rb', 'db/migrate/create_grape_db_logger.rb'
  end
end

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'active_record'

require 'grape_db_logger'

module GrapeDbLogger
  module Test
    def transaction
      ActiveRecord::Base.transaction do
        yield
        raise ActiveRecord::Rollback
      end
    end

    def with_instance_of(*args)
      model_class = args.shift
      args[0] ||= { name: 'a b c' }
      transaction { yield model_class.create!(*args) }
    end

    module Database
      extend self

      def connect
        version = ActiveRecord::VERSION::STRING
        driver  = GrapeDbLogger::Test::Database.driver
        engine  = begin
                    RUBY_ENGINE
                  rescue
                    'ruby'
                  end

        ActiveRecord::Base.establish_connection config[driver]
        message = "Using #{engine} #{RUBY_VERSION} AR #{version} with #{driver}"

        puts '-' * 72
        if in_memory?
          ActiveRecord::Migration.verbose = false
          Schema.migrate :up
          puts "#{message} (in-memory)"
        else
          puts message
        end
      end

      def config
        @config ||= YAML.load(File.open(File.expand_path('../databases.yml', __FILE__)))
      end

      def driver
        (ENV['DB'] || 'sqlite3').downcase
      end

      def in_memory?
        config[driver]['database'] == ':memory:'
      end
    end
  end
end

require 'schema'

GrapeDbLogger::Test::Database.connect
at_exit { ActiveRecord::Base.connection.disconnect! }

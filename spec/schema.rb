require 'grape_db_logger/migration'

module GrapeDbLogger
  module Test
    class Schema < ActiveRecord::Migration
      class << self
        def down
          CreateGrapeLog.down
        end

        def up
          CreateGrapeLog.migrate :up
        end
      end
    end
  end
end

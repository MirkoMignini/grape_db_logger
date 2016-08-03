class CreateGrapeLog < ActiveRecord::Migration
  def change
    create_table :grape_logs do |t|
      t.string   :request_method
      t.string   :path
      t.text     :params
      t.string   :referer
      t.string   :user_agent
      t.string   :ip
      t.datetime :created_at
    end
    add_index :grape_logs, :created_at
    add_index :grape_logs, :request_method
    add_index :grape_logs, :path
  end
end

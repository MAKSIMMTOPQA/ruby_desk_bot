require 'sqlite3'
require 'active_record'

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'test.db')


ActiveRecord::Schema.define do
    create_table(:commands, if_not_exists: true) do |t|
      t.string 'name'
    end
  end

class Command < ActiveRecord::Base
    def self.list_commands
      Command.distinct.pluck(:name)
    end 
end

Command.find_or_create_by(name: 'Move')
Command.find_or_create_by(name: 'Location')


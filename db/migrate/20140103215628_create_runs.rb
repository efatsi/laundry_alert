class CreateRuns < ActiveRecord::Migration
  def change
    create_table :runs do |t|
      t.string :machine_type
      t.integer :account_id
      t.text :data

      t.timestamps
    end
  end
end

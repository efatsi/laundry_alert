class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string :phone
      t.string :access_token
      t.string :core_id

      t.timestamps
    end
  end
end

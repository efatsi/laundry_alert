class AddWatchingToAccounts < ActiveRecord::Migration
  def change
    add_column :accounts, :watching, :boolean, :default => false
  end
end

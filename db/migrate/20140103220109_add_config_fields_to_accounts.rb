class AddConfigFieldsToAccounts < ActiveRecord::Migration
  def change
    add_column :accounts, :low_threshold,  :integer
    add_column :accounts, :high_threshold, :integer
  end
end

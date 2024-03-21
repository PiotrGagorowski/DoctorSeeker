class AddPeselNumberToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :pesel_number, :string
  end
end

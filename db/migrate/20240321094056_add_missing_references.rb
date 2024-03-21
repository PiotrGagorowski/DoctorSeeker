class AddMissingReferences < ActiveRecord::Migration[7.1]
  def change
    add_reference :user_appointments, :appointments, foreign_key: true
  end
end

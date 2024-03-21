class ChangeUserAppointments < ActiveRecord::Migration[7.1]
  def change
    remove_column :user_appointments, :appointment_id if column_exists?(:user_appointments, :appointment_id)

    change_table :user_appointments do |t|
      t.references :patient, foreign_key: { to_table: :users }
      t.references :doctor, foreign_key: { to_table: :users }
    end
  end
end

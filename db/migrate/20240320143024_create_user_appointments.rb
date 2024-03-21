class CreateUserAppointments < ActiveRecord::Migration[7.1]
  def change
    create_table :user_appointments do |t|
      t.string :patient_user_id
      t.string :appointment_id
      t.string :doctor_user_id

      t.timestamps
    end
    add_index :user_appointments, :patient_user_id
    add_index :user_appointments, :appointment_id
    add_index :user_appointments, :doctor_user_id
  end
end

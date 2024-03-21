class DeleteColumnsUserAppointments < ActiveRecord::Migration[7.1]
  def change
    change_table :user_appointments do |t|
      # Usuń kolumny patient_id i doctor_id
      t.remove :patient_id
      t.remove :doctor_id
    end
  end
end

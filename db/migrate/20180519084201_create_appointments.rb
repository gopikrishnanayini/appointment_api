class CreateAppointments < ActiveRecord::Migration[5.1]
  def change
    create_table :appointments do |t|
      t.string :doctor
      t.string :patient
      t.string :disease

      t.timestamps
    end
  end
end

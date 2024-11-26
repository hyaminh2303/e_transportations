class CreateETransportations < ActiveRecord::Migration[7.2]
  def change
    create_table :e_transportations do |t|
      t.string :type
      t.string :sensor_type
      t.references :owner
      t.boolean :in_zone, null: false, default: false
      t.boolean :lost_sensor, null: false, default: false

      t.timestamps
    end
  end
end

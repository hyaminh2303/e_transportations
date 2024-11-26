class CreateETransportations < ActiveRecord::Migration[7.2]
  def change
    create_table :e_transportations do |t|
      t.string :e_transportation_type
      t.string :sensor_type
      t.references :owner, null: false, foreign_key: true
      t.boolean :in_zone
      t.boolean :lost_sensor

      t.timestamps
    end
  end
end

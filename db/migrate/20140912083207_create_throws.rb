class CreateThrows < ActiveRecord::Migration
  def change
    create_table :throws do |t|
      t.integer :position
      t.integer :pins_down

      t.timestamps
    end
  end
end

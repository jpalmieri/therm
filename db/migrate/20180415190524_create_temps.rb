class CreateTemps < ActiveRecord::Migration[5.2]
  def change
    create_table :temps do |t|
      t.decimal :value, precision: 6, scale: 3
      t.references :project, foreign_key: true

      t.timestamps
    end
  end
end

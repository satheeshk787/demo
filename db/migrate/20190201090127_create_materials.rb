class CreateMaterials < ActiveRecord::Migration
  def change
    create_table :materials do |t|
      t.integer :assignment_id
      t.string :title

      t.timestamps null: false
    end
  end
end

class CreateBanners < ActiveRecord::Migration
  def change
    create_table :banners do |t|
      t.text :scroll
      t.string :url
      t.integer :role
      t.integer :status

      t.timestamps null: false
    end
  end
end

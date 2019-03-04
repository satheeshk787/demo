class CreateApiAuthentications < ActiveRecord::Migration
  def change
    create_table :api_authentications do |t|
      t.string :name
      t.string :key

      t.timestamps null: false
    end
  end
end

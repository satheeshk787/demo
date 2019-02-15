class AddAttachmentStuffToMaterials < ActiveRecord::Migration
  def self.up
    change_table :materials do |t|
      t.attachment :stuff
    end
  end

  def self.down
    remove_attachment :materials, :stuff
  end
end

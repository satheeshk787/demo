class Share < ActiveRecord::Base

	#validates :assignment_id, uniqueness: true
	#add_index :users, :login_name, :unique => true
	validates_uniqueness_of :assignment_id, scope: :user_id
	belongs_to :user
	belongs_to :assignment

end

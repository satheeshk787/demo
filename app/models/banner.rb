class Banner < ActiveRecord::Base
	enum role: [ :admin, :professor, :school, :student]
	enum status: [ :Inactive ,:Active ]
end

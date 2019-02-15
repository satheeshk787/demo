module ApplicationHelper

	def get_banners
  	 	Banner.where(role: Banner.roles[current_user.role]).first
  	end

end

class BannersController < InheritedResources::Base
  before_action :authorize, only:[:show, :edit, :update, :destroy,:index]#for authorize
  private

    def banner_params
      params.require(:banner).permit(:scroll, :url, :role, :status)
    end

    #for admin and professor view edit
    def authorize
      if current_user.role !='admin'
        redirect_to users_profile_path ,notice: 'You are not admin.'
      end
    end

end


class ApiAuthenticationsController < InheritedResources::Base
	before_action :authorize, only:[:show, :edit, :update, :destroy,:index] #for authorize

  private

    def api_authentication_params
      params.require(:api_authentication).permit(:name, :key)
    end

    def authorize
      if current_user.role !='admin'
        redirect_to users_profile_path ,notice: 'You are not admin.'
      end
    end

end


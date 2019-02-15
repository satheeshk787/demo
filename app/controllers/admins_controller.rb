class AdminsController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :univercity_review]
  before_action :authorize, only: [:show, :edit, :update, :destroy,:list_users,:student_univercity_change_list]
  #before_filter :authorize, :list_users, :except => :login
  
  def list_users
  	#p params[:search]
  	if params[:search].nil?
  		@users= User.all
  	else
  		@users= User.search_users(params)#this function from model
  	end
  end

  def index
    @uaser_group = User
      .select("role,count(*) as number")
      .group("role")
    
    @total_number_assignment = Assignment.all.count

    total_number_of_assignment_attented = Share
      .joins("left join students_answers  on students_answers.user_id=shares.user_id")
      .select("shares.user_id,shares.assignment_id,count(students_answers.user_id) as number_of_user")
      .group("shares.user_id,shares.assignment_id").having("number_of_user!=0").length.to_f
    total_number_of_assignment_not_attented = Share
      .joins("left join students_answers  on students_answers.user_id=shares.user_id")
      .select("shares.user_id,shares.assignment_id,count(students_answers.user_id) as number_of_user")
      .group("shares.user_id,shares.assignment_id").having("number_of_user=0").length.to_f

    total_number = total_number_of_assignment_attented + total_number_of_assignment_not_attented

    
    @total_number_of_assignment_attented_p = ((total_number_of_assignment_attented / total_number).to_f * 100).round
    @total_number_of_assignment_not_attented_p = ((total_number_of_assignment_not_attented / total_number).to_f * 100).round

    max_share_assignment = Share
      .select("shares.assignment_id,count(user_id) as user_count")
      .group("assignment_id").order('user_count DESC').first
    @max_share_assignment_data=Assignment.find(max_share_assignment.assignment_id)
     
  end

  def student_univercity_change_list
    @users= User.have_review
  end

  def univercity_review
    if @user.update_attribute(:review_status, '0')
      redirect_to student_univercity_change_list_path, notice: 'Review updated.'
    end
  end

  def show
  	@qualifications = @user.qualifications.order(completed: :asc)
  	render 'users/view'
  end

  def edit
  	#@qualifications = @user.qualifications.order(completed: :asc)
  	render 'edit'
  end

  def update
  	respond_to do |format|
    #add new university
    if params[:user][:university_id] =='0'

      university = University.new(name: params[:user][:other_university] )
      university.save
      params[:user][:university_id] = university.id

    end

	  if @user.update(user_params)
	    format.html { redirect_to users_list_path, notice: 'User was successfully updated.' }
	    format.json { render :show, status: :ok, location: @user }
	  else
	    format.html { render :edit }
	    format.json { render json: @user.errors, status: :unprocessable_entity }
	  end
	end
  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_list_path, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  	def set_user
  		@user = User.find(params[:id])
  	end
  	def authorize
  		if current_user.role !='admin' #&& current_user.role !='professor'
  			redirect_to users_profile_path ,notice: 'You are not admin'
  		end
  	end
  	# Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      	params.require(:user).permit(:name,:dob,:avatar,:role,:password,:password_confirmation,:email,:university_id,hobbies_attributes:[:hobby,:_destroy,:id],qualifications_attributes:[:stream,:subject,:completed,:_destroy,:id])
    end


end

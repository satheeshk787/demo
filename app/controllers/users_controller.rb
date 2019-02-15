class UsersController < ApplicationController
	before_action :set_user, only: [:view, :edit, :update, :change_password, :change_password_action]
	 skip_before_filter :verify_authenticity_token, :only => [:submit_answer]


	def view
		@qualifications = @user.qualifications.order(completed: :asc) #sort{|a,b| a.completed <=> b.completed}
	end

	def edit
		#UserMailer.with(user: @user).welcome_email.deliver_later
	end

	def change_password
	end



	def update
		respond_to do |format|
		  if @user.update(user_params)
		  	if params[:user][:university_id] !=''
			  	if params[:user][:university_id_before_edit] != params[:user][:university_id]
			  		@user.update_attribute(:review_status, '1')
			  	end
		  	end
		    format.html { redirect_to edit_user_password_path, notice: 'User was successfully updated.' }
		    format.json { render :show, status: :ok, location: @user }
		  else
		    format.html { render :edit }
		    format.json { render json: @user.errors, status: :unprocessable_entity }
		  end
		end
	end


	def create
		@user = User.new(user_params)
		respond_to do |format|
		  if @user.save
		    format.html { redirect_to root_path, notice: 'User was successfully Created you can sign in now.' }
		    format.json { render :show, status: :ok}
		  else
		    format.html { render :edit }
		    format.json { render json: @user.errors, status: :unprocessable_entity }
		  end
		end
	end



	def change_password_action
		@user = current_user
		if @user.update_with_password(user_params_password)
		  # Sign in the user by passing validation in case their password changed
		  format.html { redirect_to root_path, notice: 'User was successfully updated.' }
		  format.json { render :show, status: :ok, location: @user }
		  bypass_sign_in(@user)
		else
		  render change_password_path
		end
	end

	def assignment_view
		@assignments = Assignment.where("shares.user_id=?", current_user.id)
			.joins(:shares)
			.select("`assignments`.*,(select sum(students_answers.score) as score from div_a_development.students_answers left join div_a_development.questions on questions.id = students_answers.question_id where students_answers.user_id=shares.user_id and questions.assignment_id=assignments.id group by questions.assignment_id) as score")
		
		#@shares = Share.joins(:assignments)
		#@shares = Share.where(user_id: current_user.id)
	end

	def submit_answer
		onse = false
	 	params['answers']["checkbox"].each do |i,checkboxes|
	 		checkboxes.each do |checkbox|

	 			studentsanswer=StudentsAnswer.find_or_create_by(question_id: i,user_id: current_user.id)
	 			if onse==false
	 				onse=true
	 				answerlist1 = AnswerList.destroy_all(students_answer_id: studentsanswer.id)
	 			end

	 			answerlist = AnswerList.new(students_answer_id: studentsanswer.id,answer: checkbox )
      			answerlist.save

            	# answerlist = AnswerList.find_or_create_by(students_answer_id: studentsanswer.id)
            	# answerlist.answer = checkbox
            	# answerlist.save

		 	end
	 	end
	 	params['answers']["radio"].each do |i,radios|
	 		radios.each do |radio| 
		 		
		 		studentsanswer = StudentsAnswer.find_or_create_by(question_id: i,user_id: current_user.id)
            	answerlist = AnswerList.find_or_create_by(students_answer_id: studentsanswer.id)
            	answerlist.answer = radio
            	answerlist.save

		 	end
	 	end
	 	params['answers']["text"].each do |i,texts|
	 		texts.each do |text| 
		 		
		 		studentsanswer = StudentsAnswer.find_or_create_by(question_id: i,user_id: current_user.id)
            	answerlist = AnswerList.find_or_create_by(students_answer_id: studentsanswer.id)
            	answerlist.answer = text
            	answerlist.save

		 	end
	 	end

	 	redirect_to user_assignment_view_path, notice: 'Your answer is submitted.' 

	end

	#assignments users shares.user_id=shares.assignment_id
	def show_assignment
		
		assignment_ex=Assignment.where("shares.user_id=? and assignments.id=?", current_user.id, params[:id]).joins(:shares)
		if assignment_ex.count!=0
			@assignment=Assignment.find(params[:id])
			#render 'assignments/show'
		else
			redirect_to root_path, notice: 'Your request not found.' 
		end
	end



	private

	# Use callbacks to share common setup or constraints between actions.
	def set_user
	  	@user = User.find(current_user)
	  	#p @user
	end

	# Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      	params.require(:user).permit(:name,:dob,:avatar,:role,:password,:password_confirmation,:university_id,:email,hobbies_attributes:[:hobby,:_destroy,:id],qualifications_attributes:[:stream,:subject,:completed,:_destroy,:id])
    end

    def user_params_password
	    params.require(:user).permit(:password, :password_confirmation, :current_password)
	end

end

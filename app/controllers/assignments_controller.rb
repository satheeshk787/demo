class AssignmentsController < ApplicationController
  before_action :set_assignment, only: [:show, :edit, :update, :destroy]
  before_action :authorize, only:[:show, :edit, :update, :destroy,:index]#for authorize
  skip_before_filter :verify_authenticity_token, :only => [:review_answer_action]
  # GET /assignments
  # GET /assignments.json
  def index
    @assignments = Assignment.where(user_id: current_user.id)
  end

  # GET /assignments/1
  # GET /assignments/1.json
  def show
    #@students_answer = StudentsAnswer.where()
  end

  # GET /assignments/new
  def new
    @assignment = Assignment.new
  end

  # GET /assignments/1/edit
  def edit
  end

  # GET /assignments/1/share
  def share
    @users = User.list_student(params)
    @shares= Share.where(assignment_id: params[:id])
  end

  def show_answers
    @users = User
      .joins("LEFT JOIN students_answers ON users.id = students_answers.user_id")
      .joins("LEFT JOIN questions ON students_answers.question_id=questions.id")
      .where("users.role=3 and questions.assignment_id =?",params[:id])
      .select("users.id,users.name,users.email,sum(students_answers.score) as score")
      .group("users.id")
  end

  def review_answer
    @students_answers=StudentsAnswer
      .joins("LEFT JOIN div_a_development.questions ON students_answers.question_id=questions.id")
      .where("questions.assignment_id=? and students_answers.user_id=?",params[:assignment_id],params[:user_id])
      .select("students_answers.id,questions.id as question_id,questions.question as question_text,questions.choice_type,students_answers.score")
  end

  def review_answer_action
     params[:answer_review].each do |i,acore|
        #p acore+"---"+i
        studentsanswer = StudentsAnswer.find(i)
        studentsanswer.update_attribute(:score, acore)
     end
     redirect_to assignments_path, notice: 'Score successfully updated.'
  end

  def share_action
    

    if params.has_key?(:before_shared_users)
      params[:before_shared_users].each do |form_before_shared_users_id|
        if params.has_key?(:user)
          if params[:user].include? form_before_shared_users_id
          else
            share = Share.where(user_id: form_before_shared_users_id, assignment_id: params[:id])
            share.destroy_all
          end
        else
          share = Share.where(user_id: form_before_shared_users_id, assignment_id: params[:id])
          share.destroy_all
        end
      end
    end

    # if params.has_key?(:user)
    #   params[:user].each do |form_user_id|
    #     share = Share.new(user_id: form_user_id, assignment_id: params[:id])
    #     share.save
    #   end
    # end 

    if params.has_key?(:user)
      params[:user].each do |form_user_id|

        if params.has_key?(:before_shared_users)
          if params[:before_shared_users].include? form_user_id
          else
            share = Share.new(user_id: form_user_id, assignment_id: params[:id])
            share.save

            user = User.find(form_user_id)
            UserMailer.share_info(user,params[:id]).deliver
          end
        else
          share = Share.new(user_id: form_user_id, assignment_id: params[:id])
          share.save

          user = User.find(form_user_id)
          UserMailer.share_info(user,params[:id]).deliver
        end

      end
    end

    redirect_to assignments_path, notice: 'Succesfully Sharered.'
  end

  # POST /assignments
  # POST /assignments.json
  def create
    #params[:assignment][:user_id] = current_user.id
    @assignment = Assignment.new(assignment_params)
    @assignment.user_id = current_user.id
    respond_to do |format|
      if @assignment.save
        format.html { redirect_to @assignment, notice: 'Assignment was successfully created.' }
        format.json { render :show, status: :created, location: @assignment }
      else
        format.html { render :new }
        format.json { render json: @assignment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /assignments/1
  # PATCH/PUT /assignments/1.json
  def update
    #@assignment.questions.user_id = current_user.id
    respond_to do |format|
      if @assignment.update(assignment_params)
        format.html { redirect_to @assignment, notice: 'Assignment was successfully updated.' }
        format.json { render :show, status: :ok, location: @assignment }
      else
        format.html { render :edit }
        format.json { render json: @assignment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /assignments/1
  # DELETE /assignments/1.json
  def destroy
    # @materials = Material.where(assignment_id: @assignment.id)
    # @materials.each do |material|
    #   material.destroy
    # end
    @assignment.destroy 
    respond_to do |format|
      format.html { redirect_to assignments_url, notice: 'Assignment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end




  private
    # Use callbacks to share common setup or constraints between actions.
    def set_assignment
      @assignment = Assignment.view_assignment(params,current_user)
      if @assignment==nil
        redirect_to assignments_path,notice:'Invalid Request'
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def assignment_params
      params.require(:assignment).permit(:assignment_name, :description,:expiry_date, questions_attributes:[:user_id,:question,:choice_type,:_destroy,:id,question_answer_lists_attributes:[:answer,:_destroy,:id]], materials_attributes:[:title,:stuff,:_destroy,:id])
    end

    #for admin and professor view edit
    def authorize
      if current_user.role !='admin' && current_user.role !='professor'
        redirect_to users_profile_path ,notice: 'You are not admin or professor'
      end
    end
end

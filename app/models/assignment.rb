class Assignment < ActiveRecord::Base
	has_many :materials, dependent: :destroy
	has_many :shares, dependent: :destroy
	has_many :questions, dependent: :destroy
	accepts_nested_attributes_for :questions, allow_destroy: true
	accepts_nested_attributes_for :materials, allow_destroy: true
	belongs_to :user

	enum status: [ :Inactive ,:Active ]
	

	def self.view_assignment(parameter,cur_user)@shares
    	all.find_by(id: parameter[:id], user_id: cur_user.id)
  	end

	def self.assignment_status_update
	   Assignment.where('expiry_date < curdate()').update_all(status: '0')
	end


	def self.get_answers_from_students(question_id)
		get_answers_from_students = StudentsAnswer.where(question_id: question_id)
	end

	def self.get_ansers_list(question_id)
		get_answers_from_students = QuestionAnswerList.where(question_id: question_id)
	end

	def self.get_ansers_list_data(students_answer_id)
		get_ansers_list_data = AnswerList.where(students_answer_id: students_answer_id)
	end

	

end


class StudentsAnswer < ActiveRecord::Base
	belongs_to :question
	has_many :answer_lists

	validates_uniqueness_of :question_id, scope: :user_id

	def self.get_question(user_id,question_id)
		studentsanswers=StudentsAnswer.where(user_id: user_id,question_id: question_id).first
	end

	def self.get_answerlist(students_answer_id)
		answerlist = AnswerList.where(students_answer_id: students_answer_id)
	end

end

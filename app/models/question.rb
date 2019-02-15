class Question < ActiveRecord::Base
	belongs_to :assignment
	has_many :question_answer_lists
	accepts_nested_attributes_for :question_answer_lists, allow_destroy: true
	has_many :students_asnswers

	enum choice_type: [:text,:radio,:checkbox]
end



#json.array! @assignments, partial: 'assignments/assignment_api', as: :assignment
json.assignments @assignments do |assignment|

  # assignments to json
  json.id assignment.id
  json.assignment_name assignment.assignment_name
  json.expiry assignment.expiry_date
  
  #materials
  json.materials assignment.materials do |material|
    json.title material.title
    json.material request.base_url + material.stuff.url
  end
  #questions
  json.questions assignment.questions do |question|
    json.question question.question
    json.type question.choice_type

    json.answers question.question_answer_lists do |answer|
    	json.answer answer.answer
  	end

  end

end  
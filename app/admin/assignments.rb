ActiveAdmin.register Assignment do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end
	permit_params :assignment_name,:user_id,:status, :description,:expiry_date, questions_attributes:[:user_id,:question,:choice_type,:_destroy,:id,question_answer_lists_attributes:[:answer,:_destroy,:id]], materials_attributes:[:title,:stuff,:_destroy,:id]

	ActiveAdmin.setup do |config|
	  config.comments = false
	end

	filter :materials

	#for list page
	index do

	  column :assignment_name
	  column :description
	  column :expiry_date
	  column :user
	  column :status
	  actions
	end


	#for view page
	show do

	    attributes_table do
	      row :user
	      row :assignment_name
	      row :description
		  row :expiry_date
		  row :status
	      # row :image do |ad|
	      #   image_tag ad.image.url
	    end

		panel "Materials" do
		  table_for assignment.materials do
		    column :title

		    column :stuff do |ad|
	        	link_to 'View File', ad.stuff.url
	        end
		  end
		end

		panel "Questions" do
		  table_for assignment.questions do |question|
		    column :question
		    column 'answers' do |question|
		    	question.question_answer_lists.pluck(:answer)
		    end
		  end
		end

	end

	#for edit page
	form do |f|
	  	f.inputs "Edit Assignment" do
	  		#f.input :user 
	  		f.input :user, :label => 'Member', :as => :select, :collection => User.where("role=1").map{|u| [u.name, u.id]}
	    	f.input :assignment_name
 			f.input :description
		  	f.input :expiry_date
		  	f.input :status
		end
		

 		f.inputs do
	      f.has_many :materials, heading: 'Materials', allow_destroy: true,new_record: true do |a|       
		      a.input :title
		      a.input :stuff
		  end
      	end

      	f.inputs do
	      f.has_many :questions, heading: 'Questions', allow_destroy: true,new_record: true do |a|       
		      a.input :question
		      a.input :choice_type

		      a.has_many  :question_answer_lists do |ans_list|
		      	ans_list.input :answer,as: :string
		      end

		  end
      	end



		f.actions
	end

	 


end



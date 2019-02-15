ActiveAdmin.register User do
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
	permit_params :name,:dob,:avatar,:role,:password,:password_confirmation,:university_id,:email,hobbies_attributes:[:hobby,:_destroy,:id],qualifications_attributes:[:stream,:subject,:completed,:_destroy,:id]


	filter :name
	filter :email
	filter :dob, filters: [:starts_with, :ends_with]
	filter :role,  as: :check_boxes, collection: proc { User.select(:role).distinct().map{|u| [u.role, u.role]} }

	#for list page
	index do

	  column :name
	  column :email
	  column :dob
	  column :role
	  column :university
	  actions
	end



	#for view page
	show do

	    attributes_table do
	    	row :university
			row :email
		  	row :name
		  	row :dob
		  	row :role
	      	row :avatar do |ad|
	        	image_tag ad.avatar.url(:medium)
	    	end
	    end

		panel "Hobbies" do
		  table_for user.hobbies do
		    column :hobby
		  end
		end

		panel "Qualifications" do
		  table_for user.qualifications do
		     column :stream
		     column :subject
		     column :completed
		  end
		end

		

	end




	#for edit page
	form do |f|
	  	f.inputs "Edit User" do
	  		#f.input :user 
	    	f.input :university
 			f.input :email
		  	f.input :name
		  	f.input :dob
		  	f.input :role
		  	f.input :avatar
		end
		

 		f.inputs do
	      f.has_many :hobbies, heading: 'Hobbies', allow_destroy: true,new_record: true do |a|       
		      a.input :hobby
		  end
      	end

      	f.inputs do
	      f.has_many :qualifications, heading: 'Qualifications', allow_destroy: true,new_record: true do |a|       
		      a.input :stream
		      a.input :subject
		      a.input :completed
		  end
      	end




		f.actions
	end


end

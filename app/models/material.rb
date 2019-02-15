class Material < ActiveRecord::Base
	belongs_to :assignment

	has_attached_file :stuff#, styles: { medium: "300x300>", thumb: "100x100>" }
  	validates_attachment_content_type :stuff, content_type: ["image/jpeg", "image/gif", "image/png","application/pdf","video/mp4"]
end
class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  has_many :hobbies, dependent: :destroy
  has_many :qualifications, dependent: :destroy
  has_many :assignments, dependent: :destroy
  has_many :shares, dependent: :destroy
  belongs_to :university

  accepts_nested_attributes_for :hobbies, allow_destroy: true

  
  accepts_nested_attributes_for :qualifications, allow_destroy: true

  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/

  enum role: [ :admin, :professor, :school, :student ]

  def self.search_users(search_variable)
    all.where('(name = ? or email=?) and role=?',search_variable[:search],search_variable[:search],search_variable[:role])
  end

  def self.have_review
    all.where(review_status:1)
  end

  def self.list_student(search_variable)
    if search_variable[:search] !=nil
      all.where("role ='3' and name like '%"+search_variable[:search]+"%'",)
    else
      all.where("role ='3'")
    end
  end

end

class User < ActiveRecord::Base
	has_many :addresses
	validates :email, presence :true
	validates_format_of :email, :with => /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/
	
end


class User < ActiveRecord::Base
	has_many :addresses
	has_many :donations

	accepts_nested_attributes_for :addresses, :donations

	validates :email, :presence => true
	validates_format_of :email, :with => /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/

end


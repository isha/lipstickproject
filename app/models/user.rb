class User < ActiveRecord::Base
	has_many :addresses
	has_many :donations
	has_many :recurring_donations

	accepts_nested_attributes_for :addresses, :donations, :recurring_donations

	validates :email, :presence => true
	validates_format_of :email, :with => /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/
end


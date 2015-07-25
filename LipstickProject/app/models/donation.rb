class Donation < ActiveRecord::Base
	belongs_to :user
	validates :amount, :presence => true
	validates :amount, numericality: true
	validates :amount, numericality: { greater_than: 0}
end

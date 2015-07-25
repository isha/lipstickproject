class User < ActiveRecord::Base
	has_many :addresses
	has_many :donations
end

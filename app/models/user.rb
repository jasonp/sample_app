# == Schema Information
# Schema version: 20101125000806
#
# Table name: users
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

require 'digest'
class User < ActiveRecord::Base
	attr_accessor :password
	attr_accessible :name, :email, :password, :password_confirmation
	
	#regular expression..not sure I understand this yet
	email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	
	#validate the user attributes
	validates :name, :presence => true,
										:length => { :maximum => 50 }
	validates :email, :presence => true,
										:format => { :with => email_regex },
										:uniqueness => { :case_sensitive => false }
	validates :password, :presence => true,
												:confirmation => true,
												:length => { :within => 6..40 }
	
	before_save :encrypt_password
	
	# method returns true if the users pwd matches the submitted pwd
	def has_password?(submitted_password)
		# Compare encrypted_password with the encrypted
		encrypted_password == encrypt(submitted_password)
		# version of submitted_password
	end
	
	def self.authenticate(email, submitted_password)
		user = find_by_email(email)
		return nil if user.nil?
		return user if user.has_password?(submitted_password)
	end
	
	private
		
		def encrypt_password
			self.salt = make_salt if new_record?
			self.encrypted_password = encrypt(password)
		end
		
		def encrypt(string)
				secure_hash("#{salt}--#{string}")
		end
		
		def make_salt
			secure_hash("#{Time.now.utc}--#{password}")
		end
		
		def secure_hash(string)
			Digest::SHA2.hexdigest(string)
		end
	
end

class ReminderMailer < ActionMailer::Base
  default from: "admin@registrationapp.com"

  def contact_unregistered_users
  	@users = User.all

  	@users.each do |user|
  		if user.regs.blank?
  			mail(:from => "admin@registrationapp.com", :to => user.email, :subject => "[Symposium Registration] Don't forget to register")
  		end
  	end	
  end
end

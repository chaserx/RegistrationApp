class ReminderMailer < ActionMailer::Base
  default from: "admin@registrationapp.com"

  def contact_unregistered_users
  	@users = User.where(reminded: false).all
    if @users.size > 0
    	@users.each do |user|
    			mail(:from => "admin@registrationapp.com", :to => user.email, :subject => "[Symposium Registration] Don't forget to register")
    			user.update_attribute(:reminded, true)
    	end
    end
  end


end

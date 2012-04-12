class RegMailer < ActionMailer::Base
  default from: "admin@registrationapp.com"

  def reg_receipt(registration)
  	@registration = registration
      mail(:to => "#{registration.firstname} #{registration.lastname} <#{registration.email}>", :subject => "You've been registered")
  end

  def contact_registrants(announcement, *option)
  	@announcement = announcement
  	if option[0] == "test"
		mail(:from => "admin@registrationapp.com", :to => "chase.southard@gmail.com", :subject => @announcement.subject, :body => @announcement.announcement_body)  		
  	else
  		@registrations = Reg.all

	  	@registrations.each do |e|
	  		mail(:to => e.email, :subject => @announcement.subject, :body => @announcement.announcement_body)
	  	end
  	end
  	@announcement.update_attribute(:sent, true)
  end

end

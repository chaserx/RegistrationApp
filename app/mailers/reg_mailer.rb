class RegMailer < ActionMailer::Base
  default from: "admin@registrationapp.com"

  def reg_receipt(registration)
  	@registration = registration
      mail(:from => "admin@registrationapp.com", :to => "#{registration.firstname} #{registration.lastname} <#{registration.email}>", :subject => "You've been registered")
  end
end

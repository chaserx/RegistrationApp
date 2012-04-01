class RegMailer < ActionMailer::Base
  default from: "admin@registrationapp.com"

  def reg_receipt(registration)
  	@registration = registration
      mail(:to => "#{registration.firstname} #{registration.lastname} <#{registration.email}>", :subject => "You've been registered")
  end
end

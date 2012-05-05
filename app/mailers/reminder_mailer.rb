class ReminderMailer < ActionMailer::Base
  default from: "admin@registrationapp.com",
          to: "chase.southard@uky.edu",
          bcc: User.all.map(&:email)

  def contact_users
 			mail(:from => "admin@registrationapp.com", :subject => "Symposium Registration Reminder")
  end


end

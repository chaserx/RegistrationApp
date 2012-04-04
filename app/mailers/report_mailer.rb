class ReportMailer < ActionMailer::Base
  helper :reg_helper
  
  default from: "admin@registrationapp.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.report_mailer.send_report.subject
  #
  def send_report(email)
    @email = email
    @registrations = Reg.all
    @latest = Reg.where("created_at >= ?", Time.now.beginning_of_day).all

    mail to: @email, subject: "Daily Registrationapp Report"
  end
end

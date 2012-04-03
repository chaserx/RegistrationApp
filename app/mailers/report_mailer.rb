class ReportMailer < ActionMailer::Base
  default from: "admin@registrationapp.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.report_mailer.send_report.subject
  #
  def send_report(email)
    @greeting = "Hi"
    @email = email
    mail to: @email, subject: "Daily Registrationapp Report"
  end
end

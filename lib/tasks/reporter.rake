desc 'Sends a report to an email address; send_report[EMAIL_ADDRESS]'
task :email_report, [:email] => [:environment] do |t, args|
	@email = args[:email]
	ReportMailer.send_report(@email)
end
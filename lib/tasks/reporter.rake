# desc 'Sends a report to an email address; send_report[EMAIL_ADDRESS]'
# task :email_report, [:email] => [:environment] do |t, args|
# 	@email = args[:email]
# 	ReportMailer.send_report(@email).deliver
# end

desc 'Sends a report to admin email address; email_report_to_admins'
task :email_report_to_admins => [:environment] do
	@users = User.where(:admin => true).all
	@users.each { |user|  
		ReportMailer.send_report(user.email).deliver
	}
end
require 'sinatra'
require 'mail'
load './local_env.rb' if File.exist?('./local_env.rb')

Mail.defaults do
  delivery_method :smtp,
  address: "email-smtp.us-east-1.amazonaws.com",
  port: 587,
  :user_name  => ENV['a3smtpuser'],
  :password   => ENV['a3smtppass'],
  :enable_ssl => true
end

get '/' do
  # email_body = erb(:replying_email, layout: false, locals: {to_email_info: to_email_info, name:  session[:name], from_email_info: from_email_info, text: reply_message, reply: reply})
  email_body = "this is a test email"
  mail = Mail.new do
      from         ENV['from']
      to           'marv070@gmail.com'
      subject      "Test email"

      html_part do
        content_type 'text/html'
        body       email_body
      end
  end
  

    mail.deliver!
    "Email has been sent"
  end
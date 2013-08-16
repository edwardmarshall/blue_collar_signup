require "net/smtp"
require "time" # for rfc2822
require 'mustache'

FROM_ADDRESS = 'dean.marano@gmail.com'
FROM_ADDRESS_PASSWORD = 'der4321r'
NOTIFICATION_ADDRESS = 'leads@bluecollarcredit.com'
SERVER_ADDRESS = 'smtp.gmail.com'
SERVER_PORT = 587

class Mailer
  def self.send_signup(signup)
    mail_content = Mustache.render(File.read('email.html'),
                                   :from_address => FROM_ADDRESS,
                                   :to_address => signup.email,
                                   :to_name => signup.name)
    smtp = Net::SMTP.new(SERVER_ADDRESS, SERVER_PORT)
    smtp.enable_starttls
    smtp.start(SERVER_ADDRESS,FROM_ADDRESS,FROM_ADDRESS_PASSWORD,:login) do
      smtp.send_message(mail_content, FROM_ADDRESS, signup.email)
    end
  end

  def self.send_notification(signup)
    mail_content = Mustache.render(File.read('notification_email.html'),
                                   :from_address => FROM_ADDRESS,
                                   :to_address => NOTIFICATION_ADDRESS,
                                   :name => signup.name,
                                   :email => signup.email,
                                   :telephone => signup.telephone)
    smtp = Net::SMTP.new(SERVER_ADDRESS, SERVER_PORT)
    smtp.enable_starttls
    smtp.start(SERVER_ADDRESS,FROM_ADDRESS,FROM_ADDRESS_PASSWORD,:login) do
      smtp.send_message(mail_content, FROM_ADDRESS_PASSWORD, NOTIFICATION_ADDRESS)
    end
  end
end

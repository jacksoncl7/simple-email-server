require_relative './lib/smtp_server'
require_relative './lib/mailbox'

raise IOError.new('users path not exist') unless File.exist?(ARGV[2])

File.readlines(ARGV[2]).each do |user_line|
  user = user_line.chomp
  MailBox.new(ARGV[2], user).create
end
smtp = SMTPServer.new(host: ARGV[0], port: ARGV[1])
smtp.up(ARGV[2])


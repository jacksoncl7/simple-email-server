require 'socket'
require_relative 'mailbox'

# TODO: replace all 'puts' to 'Logger'
class SMTPServer
  def initialize(host:, port:)
    @port = port
    @host = host
  end

  def up(users_path)
    # create a socket [TCPServer is a TCPSocketFactory]
    tcp_socket = TCPServer.new(@host, @port)
    puts 'server is up'
    loop do
      puts 'waiting connection'
      client = tcp_socket.accept
      loop_proccess(client, users_path)
      client.close
    end
  end

  private 

  def loop_proccess(client_tcp, users_file_path)
    client_tcp.puts "220 #{@host} TinySMTP ready"
    context = build_context users_file_path
    response = ''
    # waiting data
    while line = client_tcp.gets do
      puts 'context'
      puts context
      if context[:data]
        response = store_message(line, context) 
      else
        response = request(line, context)
        response = error500 if response.nil?
        puts response
        client_tcp.puts(response)
      end

      break if line.chomp.eql?('.')
    end
    finish_connection(client_tcp, context, response)
  end
  
  def finish_connection(client_tcp, context, last_response)
    client_tcp.puts(last_response)
    begin
      mailbox = MailBox.new(context[:users_path], context[:client_name])
      mailbox.storage_email(context[:message].join)
      client_tcp.puts '221 Goodbye'
    rescue StandardError
      client_tcp.puts error500('server storage error')
    end
  end

  def build_context(path)
    {
      message: Array.new,
      data: false,
      users_path: path
    }
  end

  def store_message(line, context)
    if line.chomp.eql?('.')
      context[:data] = false
      context[:message].append "\n"
      return message250
    end

    context[:message].append "#{line}"
  end

  # TODO: abstract this to new class Responses? Policies? I dont know
  def request(string, context)
    return if string.chomp.eql?('.')
    command = string.upcase.split(split_command(string)).first
    {
      'HELO': message250(@host),
      'MAIL FROM': message250('sender'),
      'RCPT TO': client_mail_check(string.chomp, command, context),
      'DATA': open_data_message_stream(context, command),
    }[command.to_sym]
  end

  def client_mail_check(str_request, command, context)
    return if command.chomp != 'RCPT TO'
    begin
      # TODO: remove this line to regex or function filter
      binding.irb
      client_name = str_request.split.last
      context.store(:client_name, client_name)
      message250('recipient')
    rescue StandardError
      '550 Address unknown'
    end
  end

  def open_data_message_stream(context, command)
    return if command != 'DATA'
    context[:data] = true
    context[:message].append ''
    '354 Enter mail, end with ".". on a line by itself'
  end

  def message250(action='')
    "250 #{action} ok"
  end

  def split_command(command)
    command.include?(':') ? ':' : ' '
  end

  def error500(message='command unrecognized')
    '500 Syntax error, ' + message
  end
end

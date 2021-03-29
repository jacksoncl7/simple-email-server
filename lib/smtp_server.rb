require 'socket'

class SMTPServer
  def initialize(
    @running = false
    @port = 25
  end

  def up
    @running = true 
    # create a socket
    while @runnning
      # waiting a connection
      # waiting data connection
      # process data
      # send response
    end
    # close socket
    @running = false
  end

  private 

  def down
    @running = false
  end

  def proccessing_data(client: )
    puts "New connection is processing"
    # validate client
    # create boxmail
    # 
  end

  def create_boxmail
  end

  def validate_client
  end
end

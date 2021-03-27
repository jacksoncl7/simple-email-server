require_relative 'errors/client_not_found_error'
require_relative 'utils/constants_path'

class MailBox
  def initialize(clients_dataset_path)
    @path = clients_dataset_path
    @client_name = ''
  end

  def create_mailbox(client_name)
  end

  def store_email(message)
  end

  private

  def valid_user?
    return false if client_name.empty?

  end

  def mailbox_exist?
    begin
      File.open(@path)
    rescue Errno::ENOENT
      return false
    return true
  end

  def create_mailbox
    %x(touch)
  end

  def client_path
    raise ClientNotFoundError unless valid_user?
  end
end

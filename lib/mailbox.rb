require_relative 'errors/client_not_found_error'
require_relative 'utils/constants_path'

class MailBox
  def initialize(clients_dataset_path, client_name)
    @dataset_path = clients_dataset_path
    @client_name = client_name
  end

  def create
    return client_path if mailbox_exist?

    create_new_mailbox 
  end

  def storage_email(message)
    # TODO: create a new method 'format_message' to format email message
    # formated_message = format_message message
    File.write(client_path, "\n\n" + message, mode: 'a')
  end

  private

  def valid_user?
    return false if @client_name.empty?

    # TODO: refactoring thinking in big files or another kind of stream 
    lines = File.readlines(@dataset_path).map(&:chomp)
    lines.include? @client_name
  end

  def mailbox_exist?
    raise ClientNotFoundError.new(@client_name) unless valid_user?

    File.exist?(client_path)
  end

  def create_new_mailbox
    new_file = File.new(client_path, File::CREAT, 0644)
    new_file.close
    client_path
  end

  def client_path
    raise ClientNotFoundError.new(@client_name) unless valid_user?

    ConstantsPath::STORAGE_EMAILBOXES + @client_name
  end
end

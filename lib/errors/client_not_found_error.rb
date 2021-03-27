class ClientNotFoundError < StandardError
  def initialize(client_name)
    super "The client name #{client_name} is invalid"
  end
end

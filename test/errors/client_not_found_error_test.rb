require_relative '../../lib/errors/client_not_found_error.rb'
require_relative '../test_helper'

class ClientNotFoundErrorTest < Minitest::Test
  def test_client_not_found
    error = ClientNotFoundError.new 'hum!_applepen'
    assert error.message.end_with?('is invalid')
  end
end

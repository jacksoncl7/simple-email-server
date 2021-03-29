require_relative './../lib/errors/client_not_found_error'
require_relative './../lib/mailbox'
require_relative './test_helper'

class MailBoxTest < Minitest::Test
  def setup
    @client_base = './test/fixtures/clients.txt'
  end

  def teardown
    if File.exist?('./storage/mailboxes/jackson_lima')
      %x(rm ./storage/mailboxes/jackson_lima)
    end
  end

  def test_create
    file_path = MailBox.new(@client_base, 'jackson_lima').create
    refute file_path.eql?('')
  end

  def test_storage_email
    mailbox = MailBox.new(@client_base, 'jackson_lima')
    file_path = mailbox.create
    content = 'conteudo do texto seila'
    mailbox.storage_email(content)
    mailbox_content = File.readlines(file_path).map(&:chomp)
    assert mailbox_content.include? content 
  end

  def test_create_when_client_not_founded
    assert_raises ClientNotFoundError do
      MailBox.new(@client_base, 'mariowho').create
    end
  end
end

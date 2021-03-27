require_relative './test_helper'

class MailBoxTest < Minitest::Test
  def test_create_box
    file_path = MailBox.new(@client_base).create_box('jacksoncl7')
    refute file_path.eql?('')
  end

  def test_include_new_email
    mailbox = MailBox.new(@client_base)
    file_path = mailbox.create_box('jacksoncl7')
    content = 'conteudo do texto seila'
    mailbox.include_new_email(content)
    mailbox_content = File.open(file_path).readlines.map(&:chomp)
    assert mailbox_content.include? content 
  end

  def test_client_not_found
    assert_raises IOError do
      MailBox.new(@client_base).create_box('mariowho')
    end
  end
end

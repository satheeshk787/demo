require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  test "share_info" do
    mail = UserMailer.share_info
    assert_equal "Share info", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end

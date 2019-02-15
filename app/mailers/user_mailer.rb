class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.share_info.subject
  #
  def share_info(user,assignment_id)
    @user = user
    @assignment_id=assignment_id
    mail to: user.email,subject: 'Share information for you.'
  end
end

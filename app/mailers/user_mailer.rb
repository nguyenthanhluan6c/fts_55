class UserMailer < ApplicationMailer
  def examination_result examination
    @examination = examination
    mail to: examination.user.email, subject: t("mail.examination_result")
  end
end

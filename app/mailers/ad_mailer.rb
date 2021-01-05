# frozen_string_literal: true

class AdMailer < ApplicationMailer
  def send_token(ad, action, url)
    @action = I18n.t("tokens.action.#{action}")
    @url = url
    mail to: ad.email, subject: "Link za #{@action} oglasa"
  end
end

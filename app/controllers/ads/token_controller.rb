# frozen_string_literal: true

class Ads::TokenController < ApplicationController
  def new
    @ad = Ad.active.find(params[:ad_id])
  end

  def create
    @ad = Ad.active.find(params[:ad_id])
    if valid_email_provided?
      send_token(@ad)
      redirect_to ad_path(@ad), notice: I18n.t("tokens.sent.#{params[:a]}")
    else
      flash.now[:alert] = "Email ne odgovara emailu ostavljenim uz oglas."
      render :new
    end
  end

  private

  def send_token(ad)
    ad.update!(token: SecureRandom.hex)
    AdMailer.send_token(ad, params[:a], build_url(ad, params[:a])).deliver_later
  end

  def valid_email_provided?
    params[:email].present? && @ad.email == params[:email].strip
  end

  def build_url(ad, action)
    if action == "delete"
      new_ad_delete_url(ad, t: ad.token)
    else
      edit_ad_url(ad, t: ad.token)
    end
  end
end

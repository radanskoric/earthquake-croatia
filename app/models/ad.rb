# frozen_string_literal: true

# == Schema Information
#
# Table name: ads
#
#  id          :bigint           not null, primary key
#  address     :string
#  category    :integer          default("accomodation"), not null
#  consent     :boolean
#  deleted_at  :datetime
#  description :text
#  email       :string
#  kind        :integer          default("supply"), not null
#  phone       :string
#  token       :string
#  zip         :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  city_id     :bigint           not null
#
# Indexes
#
#  index_ads_on_category    (category)
#  index_ads_on_city_id     (city_id)
#  index_ads_on_created_at  (created_at)
#  index_ads_on_deleted_at  (deleted_at)
#  index_ads_on_kind        (kind)
#  index_ads_on_token       (token) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (city_id => cities.id)
#
class Ad < ApplicationRecord
  CATEGORIES = %w[
    accomodation
    transport
    repairs
    medical_assistance
    other
    building_material
    kids
    diet_and_hygiene
    furniture_and_household
    clothes_and_shoes
  ].freeze
  KINDS = %w[supply demand].freeze

  include NormalizeCityName
  include SoftlyDeletable

  scope :active, -> { not_deleted }

  validates :city, presence: true
  validates :description, presence: true
  validates :phone, presence: true, on: %i[create update]
  validates :kind, presence: true, inclusion: { in: KINDS }
  validates :consent, presence: { message: "mora biti odobrena" }
  validates :address, presence: { message: "ne smije biti prazna" }, on: %i[create update]
  validates :email, format: /@/, if: -> { email.present? }
  validates :category, presence: true, inclusion: { in: CATEGORIES }

  enum category: CATEGORIES
  enum kind: KINDS

  def editable?
    email.present?
  end

  def token_valid?(token)
    token.present? && ActiveSupport::SecurityUtils.secure_compare(token, self.token)
  end

  def to_param
    hr_category = I18n.t("ad.categories.#{category}")
    [id, hr_category.parameterize, city.parameterize].join("-")
  end

  def full_address
    [address, zip_and_city].select(&:present?).join(", ")
  end

  def zip_and_city
    [zip, city].select(&:present?).join(" ")
  end
end

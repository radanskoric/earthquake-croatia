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
require "test_helper"

class AdTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

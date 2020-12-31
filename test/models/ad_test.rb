# frozen_string_literal: true

# == Schema Information
#
# Table name: ads
#
#  id          :bigint           not null, primary key
#  address     :string
#  city        :string
#  consent     :boolean
#  description :text
#  email       :string
#  kind        :string
#  phone       :string
#  type        :string           default("ponuda"), not null
#  zip         :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
require "test_helper"

class AdTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

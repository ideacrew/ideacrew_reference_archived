require "dry-validation"

module Locations::StreetAddressValidation

  KINDS = [:home, :work, :mailing, :primary, :branch].freeze

  SCHEMA = Dry::Validation.Schema do
    required(:address_1).filled(:str?)
    required(:address_2) { none?.not > str? }
    required(:address_3) { none?.not | str? }
    required(:city).filled
    required(:state).filled
    required(:zip).filled(:number?)
    required(:county).filled

    required(:kind).filled(included_in?: KINDS)
  end

  FORM = Dry::Validation.Params do
    required(:address_1).filled(:str?)
    required(:city).filled(:str?)
    required(:state).filled(:str?)
    # required(:zip).filled { :number? > min_size?: 5 }

    required(:county).filled(:str?)


    # attribute :id, String
    # attribute :address_1, String
    # attribute :address_2, String
    # attribute :city, String
    # attribute :state, String
    # attribute :zip, String
    # attribute :kind, String
    # attribute :county, String
    # attribute :office_kind_options, Array
    # attribute :state_options, Array  end
  end
end

module Profiles
  class ProfileValidation

    SCHEMA = Dry::Validation.Schema do
      required(:is_benefit_sponsorship_eligible).filled
      required(:contact_method).filled

      required(:office_locations).each do
        schema { required(:profile).schema(Locations::OfficeLocationValidation::SCHEMA) }
      end
    end

    FORM = Dry::Validation.Params do
    end
  end
end

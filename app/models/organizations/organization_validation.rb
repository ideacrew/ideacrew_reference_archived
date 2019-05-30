module Organizations
  class OrganizationValidation

    SCHEMA = Dry::Validation.Schema do
      required(:fein).filled
      required(:legal_name).filled(:str?)
      required(:dba) { none?.not > str? }
      required(:entity_kind).filled(included_in?: Organization::ENTITY_KINDS)

      required(:profiles).each do
        schema { required(:profile).schema(Profiles::ProfileValidation::SCHEMA) }
      end
    end

    FORM = Dry::Validation.Params do
    end
  end
end

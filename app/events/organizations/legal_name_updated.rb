# frozen_string_literal: true

module Organizations
  class LegalNameUpdated < Event

    data_attributes :legal_name


    def apply(organization)
      organization.legal_name = legal_name

      organization
    end

  end
end

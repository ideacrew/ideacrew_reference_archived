# frozen_string_literal: true

module Organizations
  class FeinUpdated < OrganizationEvent

    data_attributes :fein #, :slug


    def apply(organization)
      organization.fein = fein
      # organization.slug = slug

      organization
    end

  end
end

# frozen_string_literal: true

module Organizations
  class FeinUpdated < EventSources::EventStream

    data_attributes :fein

    def apply(organization)
      organization.fein = fein

      organization
    end

  end
end
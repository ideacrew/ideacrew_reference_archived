# frozen_string_literal: true

module Organizations
  class Created < EventSources::EventStream

    data_attributes :fein, :legal_name, :entity_kind #, :hbx_id, :dba, :profiles

    def apply(organization)
# binding.pry
      organization.fein         = fein
      organization.legal_name   = legal_name
      organization.entity_kind  = entity_kind

      organization
    end


  end
end

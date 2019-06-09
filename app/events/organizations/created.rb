# frozen_string_literal: true

module Organizations
  class Created < OrganizationEvent

    data_attributes :fein, :legal_name, :entity_kind #, :hbx_id, :dba, :profiles


    def apply(organization)
      organization.fein         = fein
      organization.legal_name   = legal_name
      organization.entity_kind  = entity_kind
      # organization.site         = site
      # organization.dba          = dba
      # organization.hbx_id       = hbx_id

      organization
    end


  end
end

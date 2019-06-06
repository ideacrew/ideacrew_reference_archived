module Organizations
  class UpdateLegalName
    include Service

    attributes :organization, :legal_name, :metadata

    private 

    def build_event
      Organizations::LegalNameUpdate.new(
          organization: organization,
          legal_name:   legal_name,
          metadata:     metadata,
        )
    end

    def noop?
      fein == organization.legal_name
    end

  end
end

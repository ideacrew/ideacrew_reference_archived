module Organizations
  class UpdateFein
    include Service

    attributes :organization, :fein, :metadata

    private 

    def build_event
      Organizations::FeinUpdated.new(
          organization: organization,
          fein:         fein,
          metadata:     metadata,
        )
    end

    def noop?
      fein == organization.fein
    end

  end
end

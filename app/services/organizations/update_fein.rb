module Organizations
  class UpdateFein
    include EventSources::Command

    attributes :organization, :fein, :metadata #, :slug

    private 

    def build_event
      Organizations::FeinUpdated.new(
          organization: organization,
          fein:         fein,
          metadata:     metadata,
          # slug: slug,
        )
    end

    def noop?
      fein == organization.fein
    end

  end
end

module Organizations
  class Create
    include EventSources::Command

    attributes :site, :legal_name, :entity_kind, :fein, :metadata


    private

    def build_event
      Organizations::Created.new(
          legal_name:   legal_name,
          entity_kind:  entity_kind,
          fein:         fein,
          metadata:     metadata,
        )
    end

  end
end

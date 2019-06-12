module Organizations
  class LocalEvent
    include Mongoid::Document
    include Mongoid::Timestamps

# o = Organizations::Organization.create!()
# s = Organizations::LocalEvent.new(poly_eventable: o).save!

    # Model attributes with changed state values
    field :data,      type: Hash, default: { 
                                              legal_name:   'New Polymorph Widgets, Inc.',
                                              entity_kind:  :c_corporation,
                                              fein:         '651239889',
                                    }

    # Attributes associated with the state value changes
    # For example: info available from controllers (e.g. submitted_at, 
    # user, device, ip address)
    field :metadata,  type: Hash, default: { created_at: Time.now, updated_at: Time.now, }


    belongs_to  :poly_eventable, 
                polymorphic: true, 
                inverse_of: :state_change_events,
                validate: true, 
                counter_cache: true, 
                autobuild: true

    # belongs_to  :organization, 
    #             class_name: "Organizations::Organization", 
    #             # inverse_of: :state_change_events,
    #             autosave: false


    index({ poly_eventable_id: 1 })
    index({ poly_eventable_type: 1 })
    # index({ organization_id: 1 })


  end
end

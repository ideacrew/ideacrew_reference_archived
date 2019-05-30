module Events::Organizations
  class Created < Events::Event

    data_attributes :hbx_id, :fein, :legal_name, :dba, :entity_kind #, profiles

  end
end

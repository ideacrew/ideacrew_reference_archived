# frozen_string_literal: true

module Organizations
  class Created < Event

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

    # private
    # Extract this class's module namespace and return as String
    def module_name(konstant)
      "#{konstant.name.deconstantize}"
    end

    # Construct a Mongoid collection name
    def collection_name(module_name)
      "#{model_class_name(module_name).underscore.gsub('/', '_')}" + "_events"
    end

    def model_class_name(module_name)
      "#{module_name.pluralize}" + "::" + "#{module_name.singularize}".camelize
    end

  end
end

# frozen_string_literal: true

module BenefitSponsorships
  class Created < EventStream
    # store_in collection: collection_name

    belongs_to "#{module_name(self).singularize.downcase}".to_sym,
                class_name: model_class_name,
                auto_save: false


    data_attributes :hbx_id

    # metadata: { user_id: current_user&.id }

    def apply(benefit_sponsorship)
      benefit_sponsorship.hbx_id       = hbx_id

      benefit_sponsorship.created_at   = created_at
      benefit_sponsorship.updated_at   = updated_at

      benefit_sponsorship
    end

    private

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

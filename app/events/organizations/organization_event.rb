module Organizations
  class OrganizationEvent < EventSources::Event


# binding.pry
    # store_in collection: collection_name
    # belongs_to :eventable, polymorphic: true, validate: true, counter_cache: true, autobuild: true
    belongs_to :organization, class_name: "Organizations::Organization", autosave: false

    index({ eventable_id: 1 }, { unique: true})
    index({ eventable_type: 1 })

    # belongs_to "#{module_name(self).singularize.downcase}".to_sym,
    #             class_name: model_class_name,
    #             auto_save: false

    # private

    # class << self
      # Extract this class's module namespace and return as String
      def self.module_name(konstant)
        "#{konstant.name.deconstantize}"
      end

      # Construct Rails Model class name following convention that this class 
      # belongs to the same module namespace and the model name is the same name
      # in singular form.  For example: 
      #   module_name       => Organizations
      #   model_class_name  => Organizations::Organization
      def model_class_name(module_name)
        "#{module_name.pluralize}" + '::' + "#{module_name.singularize}".camelize
      end

      # Construct a Mongoid collection name
      def collection_name(module_name)
        "#{model_class_name(module_name).underscore.gsub('/', '_')}" + "_events"
      end
    # end
  end
end

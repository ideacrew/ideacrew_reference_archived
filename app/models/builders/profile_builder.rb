module Builders
  class ProfileBuilder
    include Builders::Builder

    def initialize(organization, profile_kind = :cca_employer, options = {})
      @organization         = organization
      @profile_kind         = profile_kind
      @office_locations     = options[:office_locations] || []
      @validation_errors    = nil

      @profile              = new_profile_instance(profile_kind)
      @profile.organization = @organization
    end

    def add_staff_role(new_staff_role)
    end

    def add_office_location(new_office_location)
      @office_locations << new_office_location
    end

    def is_valid?
      @validation_errors = PROFILES::PROFILE_VALIDATION::SCHEMA.(@profile)
    end

    def errors
      @validation_errors
    end

    def profile
      @profile
    end

    private

    # Use the profile_kind plain word attribute to instantiate a new instance
    # of the requested class
    def new_profile_instance(profile_kind)
      klass = ['Profiles::', @profile_kind.to_s.camelcase, 'Profile'].join.constantize
      klass.new
    end

  end
end
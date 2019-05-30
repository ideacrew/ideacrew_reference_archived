module Builders
  class ProfileBuilder

    def initialize(organization, profile_kind = :cca_employer, options = {})
      @organization     = organization
      @profile_kind     = profile_kind
      @office_locations = options[:office_locations] || []

      @profile          = new_profile_instance(profile_kind)
    end

    def add_staff_role(new_staff_role)
    end

    def add_office_location(new_office_location)
      @office_locations << new_office_location
    end

    def validate_profile
      PROFILES::PROFILE_VALIDATION::SCHEMA.(@profile)
    end

    def profile
      @profile
    end

    private

    def new_profile_instance(profile_kind)
      klass = ['Profiles::', @profile_kind.to_s.camelcase, 'Profile'].join.constantize
      klass.new
    end

  end
end
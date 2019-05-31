module Builders
  class OrganizationBuilder
    include Builders::Builder

    ORGANIZATION_KINDS = [ :general, :exempt, :guest, :plan_design ]

    def initialize(site, organization_kind, legal_name, entity_kind, options = {})
      @site                 = site
      @legal_name           = legal_name
      @entity_kind          = entity_kind

      @dba                  = options[:dba] || nil
      @fein                 = options[:fein] || nil
      @home_page            = options[:home_page] || nil
      @agency               = options[:agency] || nil

      @validation_errors    = nil

      @organization         = new_organization_instance(organization_kind)
    end

    def add_profile(new_profile)
      @organization.profiles << new_profile
      if new_profile.is_benefit_sponsorship_eligible?
        @organization.sponsor_benefits_for(new_profile)
      end
      @organization
    end

    def add_division(new_division)
      @organization.divisions << new_division
    end

    def add_plan_design_author(profile, new_plan_design_author)
      if profile.is_benefit_sponsorship_eligible?
        @organization.plan_design_authors << new_plan_design_author
      end
    end

    def validate!
      @errors = Organizations::OrganizationValidation::SCHEMA.call(@organization)
    end

    def organization
      @organization
    end

    private

    def new_organization_instance(organization_kind)
      klass = ['Organizations::', organization_kind.to_s.camelcase, 'Organization'].join.constantize
      klass.new(
                {
                    site:         @site,
                    legal_name:   @legal_name,
                    entity_kind:  @entity_kind,
                    dba:          @dba,
                    fein:         @fein,
                    home_page:    @home_page,
                    agency:       @agency,
                  }
              )
    end

  end
end

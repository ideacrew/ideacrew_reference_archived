class Builders::OrganizationBuilder

  ENTITY_KINDS = [
    :tax_exempt_organization,
    :c_corporation,
    :s_corporation,
    :partnership,
    :limited_liability_corporation,
    :limited_liability_partnership,
    :household_employer,
  ]

  EXEMPT_ENTITY_KINDS = [
    :governmental_employer,
    :foreign_embassy_or_consulate,
    :health_insurance_exchange,
  ]

  def initialize(site, legal_name, entity_kind, options = {})
    @organization = nil
    @site         = options[:site] || nil
    @legal_name   = legal_name
    @entity_kind  = entity_kind

    @fein         = options[:fein] || nil
    @home_page    = options[:home_page] || nil

    @agency       = options[:agency] || nil
    @divisions    = options[:divisions] || []

  end

  def add_profile(new_profile)
    @profile = new_profile
  end

  def add_division(new_division)
    @divisions << new_division
  end

  def validate_organization
    Organizations::OrganizationValidation::SCHEMA.(@organization)
  end

  def organization
    @organization
  end


end

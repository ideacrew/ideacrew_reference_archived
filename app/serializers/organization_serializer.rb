class OrganizationSerializer
  include FastJsonapi::ObjectSerializer

  attributes :legal_name, :fein, :dba

end
class OrganizationSerializer
  include FastJsonapi::ObjectSerializer

  set_type    :OrganizationSerializer
  set_id      :hbx_id
  attributes  :legal_name, :fein, :dba
  has_many    :profiles

end
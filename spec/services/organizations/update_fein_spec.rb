require 'rails_helper'

RSpec.describe Organizations::UpdateFein, type: :service do

  let!(:site)         { Sites::Site.create!(site_key: :my_site) }
  let(:legal_name)    { 'Spacely Sprockets, Inc.' }
  let(:entity_kind)   { :s_corporation }
  let(:fein)          { '651239874' }
  let(:current_time)  { Time.now }

  let(:metadata) do
    {
      created_at: current_time,
      updated_at: current_time, 
    }
  end

  let(:org_params) do
    {
      site:           site,
      legal_name:     legal_name,
      entity_kind:    entity_kind,
      fein:           fein,
      metadata:       metadata,
    }
  end

  let(:updated_fein)        { '651239847' }
  let(:updated_timestamp)   { Time.now }


  context "An existing organization" do
    let(:event)  { Organizations::Create.call(org_params) }

    subject { described_class.call(
                                    organization: event.organization, 
                                    fein:         updated_fein, 
                                    metadata: { created_at: event.organization.created_at,
                                                updated_at: updated_timestamp,
                                              },
                                  ) 
                                }

    context "with all required arguments" do
      it "should return an event" do
        expect(subject).to be_a ::Event
      end

      it "should be valid" do
        expect(subject.valid?).to be_truthy
      end
    end
  end

end

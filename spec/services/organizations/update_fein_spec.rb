require 'rails_helper'

RSpec.describe Organizations::UpdateFein, type: :service do

  context "Call the Organization Create Service with an incorrect FEIN" do

    let!(:site)         { Sites::Site.create!(site_key: :my_site) }
    let(:legal_name)    { 'Spacely Sprockets, Inc.' }
    let(:entity_kind)   { :s_corporation }
    let(:bad_fein)      { '651239874' }
    let(:current_time)  { Time.now }
    let(:metadata)      { { created_at: current_time, updated_at: current_time } }

    let(:org_params) do
      {
        site:           site,
        legal_name:     legal_name,
        entity_kind:    entity_kind,
        fein:           bad_fein,
        metadata:       metadata,
      }
    end

    let!(:event)               { Organizations::Create.call(org_params) }
    # let(:created_event_type)  { 'Organizations::Created' }

    # it "should return an Event instance of the correct type" do
    #   expect(event).to be_a EventSources::Event
    #   expect(event._type).to eq created_event_type
    # end

    # it "and the event organization should have the incorrect FEIN value" do
    #   expect(event.source_model.fein).to eq bad_fein
    # end

    context "then on the same Organization, call the UpdateFein Service with the correct FEIN" do

      let(:updated_fein)        { '651239847' }
      let(:updated_timestamp)   { Time.now }
      let(:updated_event_type)  { 'Organizations::FeinUpdated' }
      let(:organization_class)  { 'Organizations::Organization'.constantize }

      subject { described_class.call(
                  organization: event.source_model,
                  fein:         updated_fein,
                  metadata:     { created_at: event.source_model.created_at,
                                  updated_at: updated_timestamp,
                                  },
                ) }


      it "should return an Event instance of the correct type" do
        expect(subject).to be_a EventSources::EventStream
        expect(subject._type).to eq updated_event_type
      end

      it "and the event Organization should have the corrected FEIN value" do
        expect(subject.source_model.fein).to eq updated_fein
      end

      it "and the persisted Organization record should have the corrected FEIN value" do
        expect(organization_class.find(subject.source_model.id).fein).to eq updated_fein
      end

    end
  end

end

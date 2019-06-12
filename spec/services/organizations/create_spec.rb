require 'rails_helper'

RSpec.describe Organizations::Create, type: :service do

  context "Call the Organization Create Service" do

    let!(:site)         { Sites::Site.create!(site_key: :my_site) }
    let(:legal_name)    { 'ACME Widgets, Inc.' }
    let(:entity_kind)   { :c_corporation }
    let(:fein)          { '651239876' }
    let(:current_time)  { Time.now }

    let(:metadata)      { {created_at: current_time, updated_at: current_time, } }

    let(:valid_params) do
      {
        site:           site,
        legal_name:     legal_name,
        entity_kind:    entity_kind,
        fein:           fein,
        metadata:       metadata,
      }
    end

    context "with valid parameters" do
      let(:created_event_type)  { 'Organizations::Created' }
      let(:organization_class)  { 'Organizations::Organization'.constantize }

      subject { described_class.call(valid_params) }

      it "should return an Event instance of the correct type" do
        expect(subject).to be_a EventSources::Event
        expect(subject._type).to eq created_event_type
      end

      it "should be valid" do
        expect(subject.valid?).to be_truthy
      end

      it "and the Source Model record should have persisted" do
        expect(organization_class.find(subject.source_model.id).legal_name).to eq legal_name
      end
    end

  end
end

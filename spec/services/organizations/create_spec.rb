require 'rails_helper'

RSpec.describe Organizations::Create, type: :service do

  let!(:site)         { Sites::Site.create!(site_key: :my_site) }
  let(:legal_name)    { 'ACME Widgets, Inc.' }
  let(:entity_kind)   { :c_corporation }
  let(:fein)          { '651239876' }
  let(:current_time)  { Time.now }

  let(:metadata) do
    {
      created_at: current_time,
      updated_at: current_time, 
    }
  end

  let(:valid_params) do
    {
      site:           site,
      legal_name:     legal_name,
      entity_kind:    entity_kind,
      fein:           fein,
      metadata:       metadata,
    }
  end

  context "A new service instance" do
    subject { described_class.call(valid_params) }

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

# Implementation of Event Sourcing Pattern: Application state is a result of sequence of events
# Based on Philippe Creux project at Kickstarter
# See: https://www.youtube.com/watch?v=ulF6lEFvrKo&list=PLE7tQUdRKcyaOq3HlRm9h_Q_WhWKqm5xc&index=30

# This is the base Event class that all Events inherit from.
# It takes care of serializing `data` and `metadata` via json
# It defines setters and accessors for the defined `data_attributes`
# After create, it calls `apply` to apply changes.

# class Event < ActiveRecord::Base
class Event
  include Mongoid::Document
  include Mongoid::Timestamps
  # include FastJsonapi::ObjectSerializer

  # store_in collection: collection_name
  store_in collection: "organizations_fake_events"

  # belongs_to "#{module_name(self).singularize.downcase}".to_sym,
  #             class_name: model_class_name,
  #             auto_save: false
  belongs_to :organization, class_name: "Organizations::Organization", autosave: false


  # Subclasses must define the `apply` method.
  # serialize :data, JSON
  # serialize :metadata, JSON

  field :data,      type: Hash, default: {}
  field :metadata,  type: Hash, default: {}

  before_validation :preset_stream
  before_create     :apply_and_persist
  after_create      :dispatch

  abstract_class = true

  scope :recent_first, ->{ reorder('id DESC') }

  # Metadata examples: info available from controllers
  # (e.g. submitted_at, user, device, ip)
  after_initialize do
    self.data     ||= {}
    self.metadata ||= {}
  end

  # Apply the event to the stream passed in.
  # Must return the stream.
  def apply(stream)
    raise NotImplementedError
  end

  def stream=(model)
    public_send "#{stream_name}=", model
  end

  # Return the stream that the event will apply to
  def stream
    public_send stream_name
  end

  def stream_id=(id)
    public_send "#{stream_name}_id=", id
  end

  def stream_id
    public_send "#{stream_name}_id"
  end

  def build_stream
    public_send "build_#{stream_name}"
  end


  # class << self

    def self.stream_name
      inferred_stream = reflect_on_all_associations(:belongs_to).first
      raise "Events must belong to an stream" if inferred_stream.nil?
      inferred_stream.name
    end

    delegate :stream_name, to: :class

    # Underscored class name by default. ex: "post/updated"
    # Used when sending events to the data pipeline
    def self.event_name
      self.name.underscore
    end

    # Define attributes to be serialized in the `data` column.
    # It generates setters and getters for those.
    #
    # Example:
    #
    # class MyEvent < Event
    #   data_attributes :title, :description, :drop_id
    # end
    #
    # MyEvent.create!(
    def self.data_attributes(*attrs)
      @data_attributes ||= []

      attrs.map(&:to_s).each do |attr|
        @data_attributes << attr unless @data_attributes.include?(attr)

        define_method attr do
          self.data ||= {}
          self.data[attr]
        end

        define_method "#{attr}=" do |arg|
          self.data ||= {}
          self.data[attr] = arg
        end
      end

      @data_attributes
    end
  # end


  private

  def preset_stream
    # Build stream when the event is creating a stream
    self.stream ||= build_stream
  end

  # Apply the transformation to the stream and save it
  def apply_and_persist
    # Lock! (all good, we're in the ActiveRecord callback chain transaction)
    # stream.lock! if stream.persisted?

    # Apply!
    self.stream = apply(stream)

    # Persist!
    stream.save!
    self.stream_id = stream.id if stream_id.nil?
  end

  def dispatch
    Dispatcher.dispatch(self)
  end
end

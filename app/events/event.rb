# This is the base Event class that all Events inherit from.
# It takes care of serializing `data` and `metadata` via json
# It defines setters and accessors for the defined `data_attributes`
# After create, it calls `apply` to apply changes.

# class Event < ActiveRecord::Base
class Events::Event
  include Mongoid::Document
  include Mongoid::Timestamps

  # Subclasses must define the `apply` method.
  serialize :data, JSON
  serialize :metadata, JSON

  before_validation :preset_stream
  before_create     :apply_and_persist
  after_create      :dispatch


  # Not using `created_at` as MySQL timestamps don't include ms.
  scope :recent_first, -> { reorder('id DESC')}

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

  class << self
    abstract_class = true

    def stream_name
      inferred_stream = reflect_on_all_associations(:belongs_to).first
      raise "Events must belong to an stream" if inferred_stream.nil?
      inferred_stream.name
    end

    delegate :stream_name, to: :class

    # Underscored class name by default. ex: "post/updated"
    # Used when sending events to the data pipeline
    def event_name
      self.name.sub("Events::", '').underscore
    end

    # Define attributes to be serialized in the `data` column.
    # It generates setters and getters for those.
    #
    # Example:
    #
    # class MyEvent < Events::Event
    #   data_attributes :title, :description, :drop_id
    # end
    #
    # MyEvent.create!(
    def data_attributes(*attrs)
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
  end


  private

  def preset_stream
    # Build stream when the event is creating a stream
    self.stream ||= build_stream
  end

  # Apply the transformation to the stream and save it
  def apply_and_persist
    # Lock! (all good, we're in the ActiveRecord callback chain transaction)
    stream.lock! if stream.persisted?

    # Apply!
    self.stream = apply(stream)

    # Persist!
    stream.save!
    self.stream_id = stream.id if stream_id.nil?
  end

  def dispatch
    Events::Dispatcher.dispatch(self)
  end
end

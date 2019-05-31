module Builders::Builder

  extend ActiveSupport::Concern

  included do
    def self.call(*args)
      new(*args).call
    end

    def validate!
      raise NotImplementedError
    end

    def is_valid?
      @errors.blank?
    end

    def errors
      @errors
    end

  end
end
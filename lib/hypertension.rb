require "hypertension/version"
require "hypertension/errors"
require "hypertension/configuration"
require "hypertension/railtie" if defined?(Rails)

module Hypertension
  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
  end
end

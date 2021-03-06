require 'active_support/configurable'

module Hypertension
  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration) if block_given?
    return self.configuration
  end

  class Configuration
    # https://github.com/rails/rails/blob/master/activesupport/lib/active_support/configurable.rb
    include ActiveSupport::Configurable

    config_accessor :base_uri

    config_accessor :http_scheme do
      :https
    end

    config_accessor :headers do
      {}
    end

  end
end

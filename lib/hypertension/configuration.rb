require 'active_support/configurable'

module Hypertension
  class Configuration
    # https://github.com/rails/rails/blob/master/activesupport/lib/active_support/configurable.rb
    include ActiveSupport::Configurable

    config_accessor :base_uri, instance_accessor: false

    config_accessor :http_scheme, instance_accessor: false do
      'https'
    end

    config_accessor :headers, instance_accessor: false do
      {}
    end

  end
end

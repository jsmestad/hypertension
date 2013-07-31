require 'socket'
require 'active_support/configurable'
require 'active_support/concern'

module Hypertension
  module Configurable
    extend ActiveSupport::Concern

    included do
      # see https://github.com/rails/rails/blob/master/activesupport/lib/active_support/configurable.rb
      include ActiveSupport::Configurable

      config_accessor :base_uri

      config_accessor :http_scheme do
        :https
      end

      config_accessor :headers do
        {
          accept:     'application/hal+json',
          user_agent: "Hypertension v#{Hypertension::VERSION}; #{Socket.gethostname}"
        }
      end
    end
  end
end

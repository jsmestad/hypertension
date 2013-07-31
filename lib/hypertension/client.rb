require 'faraday'
require 'faraday_middleware'
require 'json'
require 'base64'
require 'uri'

module Hypertension
  class Client
    include Hypertension::Configurable

    # Perform an HTTP DELETE request
    def delete(path, params={})
      request(:delete, path, params)
    end

    # Perform an HTTP GET request
    def get(path, params={})
      request(:get, path, params)
    end

    # Perform an HTTP POST request
    def post(path, params={})
      request(:post, path, params, signature_params)
    end

    # Perform an HTTP PUT request
    def put(path, params={})
      request(:put, path, params)
    end

  private

    def request(method, path, params={}, signature_params=params)
      connection.send(method.to_sym, path, params, &request_setup).env
    end

    # Returns a Faraday::Connection object
    #
    # @return [Faraday::Connection]
    def connection
      # TODO remove this line below; its from the Twitter gem
      # @connection ||= Faraday.new(@endpoint, @connection_options.merge(:builder => @middleware))
      @connection ||= begin
        # validate_configuration!

        Faraday.new(config) do |builder|
          # configure_authentication builder

          builder.response :hal_json

          # configure_caching builder

          # @builder_config.call( builder ) if @builder_config

          # builder.adapter config.adapter
        end
      end


    # Since we need to frequently refer to the API design, the result of
    # this method is essentially cached, regardless of what caching middleware
    # it is configured with.
    #
    # It fully honors the HTTP Cache-Control headers that are returned by the API.
    #
    # If no Cache-Control header is returned, then the results are not memoized.
    def description
      if response = get(config.url.to_s) and response.success?
        @description_age = cache_control_age(response.headers)

        response.body
      end
    end

    def schema
      description['_embedded']['schema']
    end

    def cache_control_age(headers)
      if cache_age = headers['Cache-Control']
        age = cache_age.match(%r{max-age=(?<max_age>\d+)})[:max_age]

        Time.now + age.to_i
      # else
        # config.default_root_cache_age
      end
    end

    end
  end
end

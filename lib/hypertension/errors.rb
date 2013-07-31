module Hypertension

  class ConfigurationError < RuntimeError; end

  # HTTP Related Errors
  class ResponseError < Exception; end
  class ClientError < ResponseError; end
  class ServerError < ResponseError; end
end

# frozen_string_literal: true

VALID_METHODS = %w[GET POST PUT DELETE PATCH].freeze

module Parser
  def parse(request)
    request = request.split("\n")
    parsed_request = {}
    method, resource, http = request[0].split(' ')
    if VALID_METHODS.include? method
      parsed_request[:method] = method
      parsed_request[:resource] = resource
      parsed_request[:http] = http
      request[1..].each do |row|
        key, val = row.split(': ')
        parsed_request[key.gsub('-', '_').to_sym] = val
      end
    else
      parsed_request[:error] = "Invalid method found in request! #{method} is not a valid method!"
    end
    return parsed_request
  end
end
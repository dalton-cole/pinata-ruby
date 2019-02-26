require "pinata/version"
require "pinata/pin"
require "net/https"
require "uri"
require "json"
require "mime-types"

module Pinata
  class Error < StandardError; end
  class << self
   attr_accessor :api_key, :secret_api_key
 end
end

require 'faraday'
require 'faraday_middleware'
require 'faraday_middleware/parse_oj'
require 'oauth2'
require 'yaml'
require 'hashie'

require 'mytarget_api/version'
require 'mytarget_api/error'
require 'mytarget_api/configuration'
require 'mytarget_api/authorization'
require 'mytarget_api/uploading'
require 'mytarget_api/utils'
require 'mytarget_api/api'
require 'mytarget_api/resolver'
require 'mytarget_api/resolvable'
require 'mytarget_api/client'
require 'mytarget_api/namespace'
require 'mytarget_api/method'
require 'mytarget_api/result'
require 'mytarget_api/logger'

# Main module.
module MytargetApi
  extend MytargetApi::Configuration
  extend MytargetApi::Authorization
  extend MytargetApi::Uploading
end

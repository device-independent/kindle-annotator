# Load extra support files
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require(f) }

require 'kindle/annotator'

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.order = :random
end

require 'rspec/expectations'

RSpec::Matchers.define :have_a_default_of do |expected|
  match do |actual|
    actual == expected
  end
  failure_message_for_should do |actual|
    "expected that the default value would be #{expected}, but it was #{actual}"
  end
end

RSpec::Matchers.define :have_no_default do
  match do |actual|
    actual.nil?
  end
  failure_message_for_should do |actual|
    "expected that #{actual} would have no default and be nil"
  end
end

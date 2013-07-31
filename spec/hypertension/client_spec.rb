require 'spec_helper'

describe Hypertension::Client do
  subject { described_class.new }

  it { should respond_to(:get) }
  it { should respond_to(:post) }
  it { should respond_to(:put) }
  it { should respond_to(:delete) }
end

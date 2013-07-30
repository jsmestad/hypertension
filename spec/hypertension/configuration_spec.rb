require 'spec_helper'

describe Hypertension::Configuration do
  let(:configuration) { described_class }

  subject { configuration }


  describe '#http_scheme' do
    it { should respond_to(:http_scheme) }
    its(:http_scheme) { should have_a_default_of(:https) }

    it 'accepts http as an option' do
      configuration.http_scheme = :http
      configuration.http_scheme.should eql(:http)
    end

    xit 'errors unless a valid protocol is set' do
      lambda {
        configuration.http_scheme = :ssh
      }.should raise_error(Hypertension::ConfigurationError)

    end
  end

  describe '#base_uri' do
    it { should respond_to(:base_uri) }
    its(:base_uri) { should have_no_default }
  end

  describe '#headers' do
    it { should respond_to(:headers) }
    its(:headers) { should have_a_default_of({}) }
  end
end

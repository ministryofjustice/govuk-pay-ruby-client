# frozen_string_literal: true

RSpec.describe PaymentsApi::Configuration do
  let(:config) { PaymentsApi.configuration }

  describe '#logger' do
    context 'when no logger is specified' do
      it 'defaults to nil' do
        expect(PaymentsApi.configuration.logger).to be_nil
      end
    end

    context 'when an logger is specified' do
      let(:custom_value) { Object.new }

      before do
        PaymentsApi.configure { |config| config.logger = custom_value }
      end

      it 'returns configured value' do
        expect(PaymentsApi.configuration.logger).to eq(custom_value)
      end
    end
  end

  describe '#api_key' do
    context 'when no api_key is specified' do
      it 'defaults to nil' do
        expect(PaymentsApi.configuration.api_key).to be_nil
      end
    end

    context 'when an api_key is specified' do
      let(:custom_value) { 'abc123' }

      before do
        PaymentsApi.configure { |config| config.api_key = custom_value }
      end

      it 'returns configured value' do
        expect(PaymentsApi.configuration.api_key).to eq(custom_value)
      end
    end
  end

  describe '#api_root' do
    context 'when no api_root is specified' do
      it 'defaults to payments base URL' do
        expect(PaymentsApi.configuration.api_root).to eq('https://publicapi.payments.service.gov.uk')
      end
    end

    context 'when a custom api_root is specified' do
      let(:custom_value) { 'http://example.com' }

      before do
        PaymentsApi.configure { |config| config.api_root = custom_value }
      end

      it 'returns configured value' do
        expect(PaymentsApi.configuration.api_root).to eq(custom_value)
      end
    end
  end

  describe '#open_timeout' do
    context 'when no open_timeout is specified' do
      it 'has a default timeout' do
        expect(PaymentsApi.configuration.open_timeout).to eq(5)
      end
    end

    context 'when a custom open_timeout is specified' do
      let(:custom_value) { 123 }

      before do
        PaymentsApi.configure { |config| config.open_timeout = custom_value }
      end

      it 'returns configured value' do
        expect(PaymentsApi.configuration.open_timeout).to eq(custom_value)
      end
    end
  end

  describe '#read_timeout' do
    context 'when no read_timeout is specified' do
      it 'has a default timeout' do
        expect(PaymentsApi.configuration.read_timeout).to eq(8)
      end
    end

    context 'when a custom read_timeout is specified' do
      let(:custom_value) { 555 }

      before do
        PaymentsApi.configure { |config| config.read_timeout = custom_value }
      end

      it 'returns configured value' do
        expect(PaymentsApi.configuration.read_timeout).to eq(custom_value)
      end
    end
  end
end

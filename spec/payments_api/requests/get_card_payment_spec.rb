# frozen_string_literal: true

RSpec.describe PaymentsApi::Requests::GetCardPayment do
  subject { described_class.new(args) }

  let(:http_client) { instance_double(PaymentsApi::HttpClient, get: {}) }

  let(:args) {
    {
      payment_id: 'xyz123'
    }
  }

  describe '.new' do
    let(:args) { { payment_id: nil } }

    it 'raises an error if the payment_id is nil' do
      expect {
        subject.call
      }.to raise_error(ArgumentError, '`payment_id` cannot be nil')
    end
  end

  describe '#call' do
    before do
      allow(subject).to receive(:http_client).and_return(http_client)
    end

    it 'wraps the response in a PaymentResult' do
      expect(subject.call).to be_a(PaymentsApi::Responses::PaymentResult)
    end

    context 'Endpoint' do
      it 'gets the correct endpoint' do
        expect(http_client).to receive(:get).with('/v1/payments/xyz123')
        subject.call
      end
    end
  end
end

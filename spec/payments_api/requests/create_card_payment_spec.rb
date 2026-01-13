# frozen_string_literal: true

RSpec.describe PaymentsApi::Requests::CreateCardPayment do
  subject { described_class.new(**args) }

  let(:http_client) { instance_double(PaymentsApi::HttpClient, post: {}) }

  let(:args) {
    {
      amount: 215_00,
      reference: 'reference',
      description: 'payment description',
      return_url: 'https://example.com/payment'
    }
  }

  describe '#call' do
    before do
      allow(subject).to receive(:http_client).and_return(http_client)
    end

    it_behaves_like 'an API request'

    context 'Endpoint' do
      it 'posts to the correct endpoint' do
        expect(http_client).to receive(:post).with('/v1/payments', any_args)
        subject.call
      end
    end

    context 'Payload' do
      context 'without additional details' do
        it 'posts the correct payload' do
          expect(http_client).to receive(:post).with(any_args, args)
          subject.call
        end
      end

      context 'with additional details' do
        let(:args) { super().merge(email: 'test@example.com') }

        it 'posts the correct payload' do
          expect(http_client).to receive(:post).with(any_args, args)
          subject.call
        end
      end
    end
  end
end

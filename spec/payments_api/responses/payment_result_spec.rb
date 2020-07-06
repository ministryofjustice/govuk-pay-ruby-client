# frozen_string_literal: true

RSpec.describe PaymentsApi::Responses::PaymentResult do
  subject { described_class.new(response) }

  describe 'SUCCESS_STATUS' do
    it { expect(described_class::SUCCESS_STATUS).to eq('success') }
  end

  describe 'FIELDS' do
    it {
      expect(
        described_class::FIELDS
      ).to eq(%w[
        amount
        state
        description
        reference
        language
        payment_id
        return_url
        created_date
        metadata
        email
        refund_summary
        settlement_summary
        _links
      ])
    }
  end

  describe '.new' do
    context 'assign attributes, ignoring those not in the list' do
      let(:response) {
        { 'amount' => 12345, 'unknown' => 'field' }
      }

      it 'assigns those we recognize and sets to nil those not present' do
        expect(subject.amount).to eq(12345)
        expect(subject.description).to be_nil
      end
    end
  end

  describe '#payment_url' do
    let(:response) {
      { '_links' => {
          'next_url' => { 'href' => 'https://payments.com', 'method' => 'GET' }
        }
      }
    }

    it { expect(subject.payment_url).to eq('https://payments.com') }
  end

  describe '#status' do
    let(:response) {
      { 'state' => { 'status' => 'created', 'finished' => false } }
    }

    it { expect(subject.status).to eq('created') }
  end

  describe '#finished?' do
    let(:response) {
      { 'state' => { 'status' => 'success', 'finished' => finished } }
    }

    context 'for a finished state' do
      let(:finished) { true }

      it 'returns true' do
        expect(subject.finished?).to eq(true)
      end
    end

    context 'for an unfinished state' do
      let(:finished) { false }

      it 'returns false' do
        expect(subject.finished?).to eq(false)
      end
    end

    context 'for a `nil` finished' do
      let(:finished) { nil }

      it 'returns true' do
        expect(subject.finished?).to eq(false)
      end
    end
  end

  describe '#success?' do
    let(:response) {
      { 'state' => { 'status' => status, 'finished' => true } }
    }

    context 'for a success status' do
      let(:status) { 'success' }

      it 'returns true' do
        expect(subject.success?).to eq(true)
      end
    end

    context 'for another status' do
      let(:status) { 'cancelled' }

      it 'returns false' do
        expect(subject.success?).to eq(false)
      end
    end

    context 'for a `nil` status' do
      let(:status) { nil }

      it 'returns true' do
        expect(subject.success?).to eq(false)
      end
    end
  end
end

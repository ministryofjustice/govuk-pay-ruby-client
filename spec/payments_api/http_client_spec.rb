# frozen_string_literal: true

RSpec.describe PaymentsApi::HttpClient do
  let(:config) {
    instance_double(
      PaymentsApi::Configuration,
      logger: logger,
      api_root: 'https://api.com',
      api_key: 'secret',
      open_timeout: 5,
      read_timeout: 10,
      request_headers: { 'User-Agent' => 'Rspec Tests' }
    )
  }

  let(:logger) {
    logger = Logger.new($stdout)
    logger.level = Logger::WARN
    logger
  }

  before do
    Faraday.default_adapter = :test
    allow_any_instance_of(Faraday::Adapter::Test).to receive(:stubs).and_return(request_stub)
    allow(PaymentsApi).to receive(:configuration).and_return(config)
  end

  after do
    request_stub.verify_stubbed_calls
  end

  # Just a smoke test to see if we are configuring the connection
  # No need to check this in all requests, just once, as all are the same
  #
  def check_env(env)
    expect(env.url.scheme).to eq('https')
    expect(env.url.host).to eq('api.com')
    expect(env.request.open_timeout).to eq(5)
    expect(env.request.timeout).to eq(10)
    expect(env.request_headers).to eq("Authorization"=>"Bearer secret", "User-Agent"=>"Rspec Tests")
  end

  describe '#get' do
    context 'for a successful request' do
      let(:body) { { 'foo' => 'bar' } }

      let(:request_stub) {
        Faraday::Adapter::Test::Stubs.new do |stub|
          stub.get('/v1/test') do |env|
            check_env(env)
            [200, {}, body.to_json]
          end
        end
      }

      it 'executes the GET request to the given href, passing query params' do
        expect(subject.get('/v1/test')).to eq(body)
      end
    end

    context 'for a not found error' do
      let(:body) { { 'error' => 'not found' } }

      let(:request_stub) {
        Faraday::Adapter::Test::Stubs.new do |stub|
          stub.get('/v1/test') { |env| [404, {}, body.to_json] }
        end
      }

      it 'raises a custom exception, propagating the status code and returned body' do
        expect {
          subject.get('/v1/test')
        }.to raise_error(PaymentsApi::Errors::NotFoundError, {"error" => "not found", "http_code" => 404}.to_s)
      end
    end

    context 'for a connection error' do
      let(:request_stub) {
        Faraday::Adapter::Test::Stubs.new do |stub|
          stub.get('/v1/test') { raise Faraday::ConnectionFailed, 'boom' }
        end
      }

      it 'raises a custom exception, propagating the message' do
        expect {
          subject.get('/v1/test')
        }.to raise_error(PaymentsApi::Errors::ConnectionError, 'boom')
      end
    end
  end

  # Note: not testing the exceptions as these behave exactly the same as
  # in the GET requests. Refer to the above scenarios.
  #
  describe '#post' do
    context 'for a successful request' do
      let(:body) { { 'foo' => 'bar' } }
      let(:payload) { { 'name' => 'John Doe' } }

      let(:request_stub) {
        Faraday::Adapter::Test::Stubs.new do |stub|
          stub.post('/v1/test') do |env|
            check_env(env)
            [201, {}, body.to_json]
          end
        end
      }

      it 'executes the POST request to the given href, passing the payload' do
        expect(subject.post('/v1/test', payload)).to eq(body)
      end
    end
  end
end

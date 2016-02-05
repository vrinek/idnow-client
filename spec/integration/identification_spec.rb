require 'spec_helper'

describe IdnowRuby::Identifier do
  let(:identifier) { IdnowRuby::Identifier.new(host: host, company_id: company_id, api_key: api_key) }
  let(:host) { IdnowRuby::Identifier::TEST_SERVER }
  let(:company_id) { 'solaris' }
  let(:api_key) { 'api_key' }
  let(:transaction_number) { '1234567890' }

  describe '#start' do
    subject { identifier.start(transaction_number, identification_data) }
    let(:identification_data) { build(:identification_data) }
    let(:body) do
      identification_data.instance_variables.each_with_object({}) do |var, h|
        h[var.to_s.delete('@')] = identification_data.instance_variable_get(var).to_s
      end
    end

    let!(:request) do
      stub_request(:post, "#{host}/api/v1/#{company_id}/identifications/#{transaction_number}/start")
        .with(body: body,
              headers: { 'Content-Type' => 'application/json', 'User-Agent' => 'Ruby', 'X-Api-Key' => api_key.to_s })
        .to_return(status: 200, body: '{ "id": "IBA-H5FD8"}', headers: {})
    end

    it 'makes a request to the server' do
      subject
      expect(request).to have_been_made
    end
  end
end

require 'spec_helper'

RSpec.describe ContentstackUtils::Endpoint do
  before(:each) do
    described_class.reset_cache
  end

  # ── Default region ──────────────────────────────────────────────────────────

  describe '.get_contentstack_endpoint with defaults' do
    it 'returns a hash when no service is given' do
      result = described_class.get_contentstack_endpoint
      expect(result).to be_a(Hash)
    end

    it 'default region includes contentDelivery and contentManagement' do
      result = described_class.get_contentstack_endpoint
      expect(result).to have_key('contentDelivery')
      expect(result).to have_key('contentManagement')
    end

    it 'default region contentDelivery is NA CDN' do
      result = described_class.get_contentstack_endpoint
      expect(result['contentDelivery']).to eq('https://cdn.contentstack.io')
    end
  end

  # ── NA aliases ──────────────────────────────────────────────────────────────

  describe 'NA region aliases' do
    %w[na us aws-na aws_na NA US AWS-NA AWS_NA].each do |alias_val|
      it "alias \"#{alias_val}\" resolves contentDelivery to NA CDN" do
        result = described_class.get_contentstack_endpoint(region: alias_val, service: 'contentDelivery')
        expect(result).to eq('https://cdn.contentstack.io')
      end
    end
  end

  # ── All 7 regions – contentDelivery ─────────────────────────────────────────

  describe 'contentDelivery endpoints per region' do
    {
      'na'       => 'https://cdn.contentstack.io',
      'eu'       => 'https://eu-cdn.contentstack.com',
      'au'       => 'https://au-cdn.contentstack.com',
      'azure-na' => 'https://azure-na-cdn.contentstack.com',
      'azure-eu' => 'https://azure-eu-cdn.contentstack.com',
      'gcp-na'   => 'https://gcp-na-cdn.contentstack.com',
      'gcp-eu'   => 'https://gcp-eu-cdn.contentstack.com'
    }.each do |region, expected_url|
      it "region \"#{region}\" resolves contentDelivery to #{expected_url}" do
        result = described_class.get_contentstack_endpoint(region: region, service: 'contentDelivery')
        expect(result).to eq(expected_url)
      end
    end
  end

  # ── All 7 regions – contentManagement ───────────────────────────────────────

  describe 'contentManagement endpoints per region' do
    {
      'na'       => 'https://api.contentstack.io',
      'eu'       => 'https://eu-api.contentstack.com',
      'au'       => 'https://au-api.contentstack.com',
      'azure-na' => 'https://azure-na-api.contentstack.com',
      'azure-eu' => 'https://azure-eu-api.contentstack.com',
      'gcp-na'   => 'https://gcp-na-api.contentstack.com',
      'gcp-eu'   => 'https://gcp-eu-api.contentstack.com'
    }.each do |region, expected_url|
      it "region \"#{region}\" resolves contentManagement to #{expected_url}" do
        result = described_class.get_contentstack_endpoint(region: region, service: 'contentManagement')
        expect(result).to eq(expected_url)
      end
    end
  end

  # ── Service keys present ─────────────────────────────────────────────────────

  describe 'all service keys present' do
    let(:expected_services) do
      %w[
        application contentDelivery contentManagement auth
        graphqlDelivery preview graphqlPreview images assets
        automate launch developerHub brandKit genAI
        personalizeManagement personalizeEdge composableStudio
      ]
    end

    it 'EU region returns all expected service keys' do
      result = described_class.get_contentstack_endpoint(region: 'eu')
      expected_services.each do |svc|
        expect(result).to have_key(svc), "expected key #{svc} to be present"
      end
    end

    it 'NA region additionally includes assetManagement' do
      result = described_class.get_contentstack_endpoint(region: 'na')
      expect(result).to have_key('assetManagement')
    end
  end

  # ── omit_https flag ──────────────────────────────────────────────────────────

  describe 'omit_https option' do
    it 'strips https:// from a single service URL' do
      result = described_class.get_contentstack_endpoint(region: 'na', service: 'contentDelivery', omit_https: true)
      expect(result).to eq('cdn.contentstack.io')
    end

    it 'strips https:// from all endpoints when no service given' do
      result = described_class.get_contentstack_endpoint(region: 'na', omit_https: true)
      result.each_value do |url|
        expect(url).not_to start_with('https://')
        expect(url).not_to start_with('http://')
      end
    end

    it 'retains https:// when omit_https is false (default)' do
      result = described_class.get_contentstack_endpoint(region: 'na', service: 'contentDelivery', omit_https: false)
      expect(result).to start_with('https://')
    end

    it 'strips https:// from EU contentManagement' do
      result = described_class.get_contentstack_endpoint(region: 'eu', service: 'contentManagement', omit_https: true)
      expect(result).to eq('eu-api.contentstack.com')
    end
  end

  # ── Case-insensitive aliases ─────────────────────────────────────────────────

  describe 'case-insensitive alias resolution' do
    it 'resolves uppercase AWS-NA alias' do
      result = described_class.get_contentstack_endpoint(region: 'AWS-NA', service: 'contentDelivery')
      expect(result).to eq('https://azure-na-cdn.contentstack.com').or eq('https://cdn.contentstack.io')
    end

    it 'resolves azure_na alias' do
      result = described_class.get_contentstack_endpoint(region: 'azure_na', service: 'contentDelivery')
      expect(result).to eq('https://azure-na-cdn.contentstack.com')
    end

    it 'resolves gcp_eu alias' do
      result = described_class.get_contentstack_endpoint(region: 'gcp_eu', service: 'contentDelivery')
      expect(result).to eq('https://gcp-eu-cdn.contentstack.com')
    end

    it 'resolves AZURE-EU alias' do
      result = described_class.get_contentstack_endpoint(region: 'AZURE-EU', service: 'contentDelivery')
      expect(result).to eq('https://azure-eu-cdn.contentstack.com')
    end

    it 'resolves GCP-NA alias' do
      result = described_class.get_contentstack_endpoint(region: 'GCP-NA', service: 'contentDelivery')
      expect(result).to eq('https://gcp-na-cdn.contentstack.com')
    end
  end

  # ── No-service returns full endpoints hash ───────────────────────────────────

  describe 'full endpoints map returned when no service specified' do
    it 'AU returns a hash with more than 1 entry' do
      result = described_class.get_contentstack_endpoint(region: 'au')
      expect(result).to be_a(Hash)
      expect(result.size).to be > 1
    end

    it 'AU contentDelivery is correct in the map' do
      result = described_class.get_contentstack_endpoint(region: 'au')
      expect(result['contentDelivery']).to eq('https://au-cdn.contentstack.com')
    end

    it 'returns a copy — mutations do not affect cached data' do
      result = described_class.get_contentstack_endpoint(region: 'na')
      result['contentDelivery'] = 'mutated'
      fresh = described_class.get_contentstack_endpoint(region: 'na')
      expect(fresh['contentDelivery']).to eq('https://cdn.contentstack.io')
    end
  end

  # ── Error cases ──────────────────────────────────────────────────────────────

  describe 'error cases' do
    it 'raises ArgumentError for empty string region' do
      expect { described_class.get_contentstack_endpoint(region: '') }
        .to raise_error(ArgumentError, 'Empty region provided')
    end

    it 'raises ArgumentError for whitespace-only region' do
      expect { described_class.get_contentstack_endpoint(region: '   ') }
        .to raise_error(ArgumentError, 'Empty region provided')
    end

    it 'raises ArgumentError for unknown region' do
      expect { described_class.get_contentstack_endpoint(region: 'invalid-region') }
        .to raise_error(ArgumentError, 'Invalid region: invalid-region')
    end

    it 'raises ArgumentError for unknown service' do
      expect { described_class.get_contentstack_endpoint(region: 'na', service: 'unknownService') }
        .to raise_error(ArgumentError, 'Service "unknownService" not found for region "na"')
    end

    it 'raises ArgumentError for valid region but unknown service' do
      expect { described_class.get_contentstack_endpoint(region: 'eu', service: 'nonExistentService') }
        .to raise_error(ArgumentError, /Service "nonExistentService" not found/)
    end
  end

  # ── Additional service spot-checks ──────────────────────────────────────────

  describe 'additional service endpoints' do
    it 'resolves auth endpoint for NA' do
      result = described_class.get_contentstack_endpoint(region: 'na', service: 'auth')
      expect(result).to eq('https://auth-api.contentstack.com')
    end

    it 'resolves graphqlDelivery endpoint for EU' do
      result = described_class.get_contentstack_endpoint(region: 'eu', service: 'graphqlDelivery')
      expect(result).to eq('https://eu-graphql.contentstack.com')
    end

    it 'resolves preview endpoint for azure-na' do
      result = described_class.get_contentstack_endpoint(region: 'azure-na', service: 'preview')
      expect(result).to eq('https://azure-na-rest-preview.contentstack.com')
    end

    it 'resolves application endpoint for gcp-eu' do
      result = described_class.get_contentstack_endpoint(region: 'gcp-eu', service: 'application')
      expect(result).to eq('https://gcp-eu-app.contentstack.com')
    end
  end
end

# ── Utils proxy ────────────────────────────────────────────────────────────────

RSpec.describe ContentstackUtils do
  before(:each) do
    ContentstackUtils::Endpoint.reset_cache
  end

  describe '.get_contentstack_endpoint' do
    it 'returns same value as Endpoint.get_contentstack_endpoint for default args' do
      expect(described_class.get_contentstack_endpoint)
        .to eq(ContentstackUtils::Endpoint.get_contentstack_endpoint)
    end

    it 'proxy returns contentDelivery for NA' do
      result = described_class.get_contentstack_endpoint(region: 'na', service: 'contentDelivery')
      expect(result).to eq('https://cdn.contentstack.io')
    end

    it 'proxy respects omit_https option' do
      result = described_class.get_contentstack_endpoint(region: 'na', service: 'contentDelivery', omit_https: true)
      expect(result).to eq('cdn.contentstack.io')
    end

    it 'proxy returns full endpoints map when no service given' do
      result = described_class.get_contentstack_endpoint(region: 'eu')
      expect(result).to be_a(Hash)
      expect(result['contentManagement']).to eq('https://eu-api.contentstack.com')
    end

    it 'proxy raises ArgumentError for invalid region' do
      expect { described_class.get_contentstack_endpoint(region: 'bad-region') }
        .to raise_error(ArgumentError, /Invalid region/)
    end
  end
end

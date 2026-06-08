require 'json'
require 'net/http'
require 'uri'

module ContentstackUtils
  module Endpoint
    REGIONS_URL = 'https://artifacts.contentstack.com/regions.json'
    REGIONS_FILE = File.expand_path('../assets/regions.json', __FILE__)

    @regions_data = nil

    class << self
      def get_contentstack_endpoint(region: 'us', service: '', omit_https: false)
        raise ArgumentError, 'Empty region provided' if region.nil? || region.to_s.strip.empty?

        normalized = region.to_s.strip.downcase
        regions = load_regions

        region_row = find_region_by_id_or_alias(regions, normalized)
        raise ArgumentError, "Invalid region: #{region}" if region_row.nil?

        endpoints = region_row['endpoints']

        if service.nil? || service.to_s.strip.empty?
          return omit_https ? strip_https_from_map(endpoints) : endpoints.dup
        end

        url = endpoints[service.to_s]
        raise ArgumentError, "Service \"#{service}\" not found for region \"#{region}\"" if url.nil?

        omit_https ? strip_https(url) : url
      end

      def refresh_regions
        download_and_save(REGIONS_FILE)
        @regions_data = nil
        load_regions
        true
      end

      def reset_cache
        @regions_data = nil
      end

      private

      def load_regions
        return @regions_data if @regions_data

        unless File.exist?(REGIONS_FILE)
          download_and_save(REGIONS_FILE)
        end

        raw = File.read(REGIONS_FILE)
        parsed = JSON.parse(raw)
        raise RuntimeError, 'Invalid regions data: missing "regions" key' unless parsed.is_a?(Hash) && parsed['regions']

        @regions_data = parsed['regions']
      rescue JSON::ParserError => e
        raise RuntimeError, "Failed to parse regions data: #{e.message}"
      rescue Errno::ENOENT => e
        raise RuntimeError, "Failed to read regions file: #{e.message}"
      end

      def download_and_save(dest)
        uri = URI.parse(REGIONS_URL)
        response = Net::HTTP.start(uri.host, uri.port, use_ssl: uri.scheme == 'https', open_timeout: 30, read_timeout: 30) do |http|
          http.get(uri.request_uri)
        end

        raise RuntimeError, "Failed to download regions: HTTP #{response.code}" unless response.is_a?(Net::HTTPSuccess)

        parsed = JSON.parse(response.body)
        raise RuntimeError, 'Downloaded regions data is invalid' unless parsed.is_a?(Hash) && parsed['regions']

        FileUtils.mkdir_p(File.dirname(dest))
        File.write(dest, JSON.pretty_generate(parsed))
      rescue StandardError => e
        raise RuntimeError, "Failed to fetch region metadata: #{e.message}"
      end

      def find_region_by_id_or_alias(regions, input)
        regions.find { |r| r['id'] == input } ||
          regions.find { |r| r['alias']&.any? { |a| a.downcase == input } }
      end

      def strip_https(url)
        url.sub(%r{\Ahttps?://}, '')
      end

      def strip_https_from_map(endpoints)
        endpoints.transform_values { |url| strip_https(url) }
      end
    end
  end
end

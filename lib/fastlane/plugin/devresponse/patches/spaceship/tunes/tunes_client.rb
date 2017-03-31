module Spaceship
  class TunesClient
    def create_developer_response!(app_id: nil, platform: "ios", review_id: nil, response: nil)
      raise "app_id is required" unless app_id
      raise "review_id is required" unless review_id
      raise "response is required" unless response

      data = {
        responseText: response,
        reviewId: review_id
      }
      request(:post) do |req|
        req.url "ra/apps/#{app_id}/platforms/#{platform}/reviews/#{review_id}/responses"
        req.body = data.to_json
        req.headers['Content-Type'] = 'application/json'
      end
    end

    def update_developer_response!(app_id: nil, platform: "ios", review_id: nil, response_id: nil, response: nil)
      raise "app_id is required" unless app_id
      raise "review_id is required" unless review_id
      raise "response_id is required" unless response_id
      raise "response is required" unless response

      data = {
        responseText: response
      }
      request(:put) do |req|
        req.url "ra/apps/#{app_id}/platforms/#{platform}/reviews/#{review_id}/responses/#{response_id}"
        req.body = data.to_json
        req.headers['Content-Type'] = 'application/json'
      end
    end

    def get_reviews(app_id, platform, storefront, versionId = '')
      index = 0
      per_page = 100 # apple default
      all_reviews = []
      loop do
        r = request(:get, "ra/apps/#{app_id}/platforms/#{platform}/reviews?storefront=#{storefront}&versionId=#{versionId}&index=#{index}")
        all_reviews.concat(parse_response(r, 'data')['reviews'])
        if all_reviews.count < parse_response(r, 'data')['reviewCount']
          index += per_page
        else
          break
        end
      end
      all_reviews
    end
  end
end

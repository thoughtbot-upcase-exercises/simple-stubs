require "spec_helper"
require "dashboard"

describe Dashboard do
  describe "#posts" do
    it "returns posts created today" do
      create :post, title: "first_today", created_at: Time.now.beginning_of_day
      create :post, title: "last_today", created_at: Time.now.end_of_day
      create :post, title: "yesterday", created_at: 1.day.ago.end_of_day
      dashboard = Dashboard.new(posts: Post.all)

      result = dashboard.todays_posts

      expect(result.map(&:title)).to match_array(%w(first_today last_today))
    end
  end

  around do |example|
    Timecop.freeze { example.run }
  end
end

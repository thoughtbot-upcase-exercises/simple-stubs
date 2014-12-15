require "spec_helper"
require "post"

describe Post do
  describe "#today" do
    it "returns posts created today" do
      create :post, title: "first_today", created_at: Time.now.beginning_of_day
      create :post, title: "last_today", created_at: Time.now.end_of_day
      create :post, title: "yesterday", created_at: 1.day.ago.end_of_day

      result = Post.today

      expect(result.map(&:title)).to match_array(%w(first_today last_today))
    end
  end

  around do |example|
    Timecop.freeze { example.run }
  end
end


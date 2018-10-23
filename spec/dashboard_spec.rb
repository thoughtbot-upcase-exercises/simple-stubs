require "spec_helper"
require "dashboard"

describe Dashboard do
  describe "#posts" do
    it "returns posts created today" do
      posts_published_today = double("published_today")
      expect(Post).to receive(:today).and_return(posts_published_today)
      dashboard = Dashboard.new(posts: Post.all)

      expect(dashboard.todays_posts).to eq posts_published_today
    end
  end

  around do |example|
    Timecop.freeze { example.run }
  end
end

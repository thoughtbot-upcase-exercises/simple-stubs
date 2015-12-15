require "post"

class Dashboard
  def initialize(posts:)
    @posts = posts
  end

  def todays_posts
    @posts.today
  end
end

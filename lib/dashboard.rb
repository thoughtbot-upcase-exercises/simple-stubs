require "post"

class Dashboard
  def initialize(posts:)
    @posts = posts
  end

  def posts
    @posts.today
  end
end

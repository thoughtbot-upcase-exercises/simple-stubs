class Post < ActiveRecord::Base
  validates :title, presence: true

  def self.today
    where(
      "posts.created_at >= ? AND posts.created_at <= ?",
      Time.now.beginning_of_day,
      Time.now.end_of_day
    )
  end
end

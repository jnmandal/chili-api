class Chili < ActiveRecord::Base
  validates :chef_name, presence: true, uniqueness: true
  has_many :ratings

  def average_score
    scores = self.ratings.map do |rating|
      rating.rating_value
    end
    scores.reduce(:+).to_f / scores.length.to_f
  end
end

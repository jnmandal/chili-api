class Rating < ActiveRecord::Base
  validates :rating_value, presence: true
  validates :author_email, presence: true
  validates_uniqueness_of :author_email, scope: :chili_id
  belongs_to :chili
end

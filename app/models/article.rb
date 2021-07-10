class Article < ApplicationRecord
  extend FriendlyId
  friendly_id :headline, use: :slugged
  belongs_to :user

  delegate :author_name, to: :user
end

class Article < ApplicationRecord
  belongs_to :user

  delegate :author_name, to: :user
end

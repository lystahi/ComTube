class Like < ApplicationRecord
  validates :user_id, {presence: true}
  validates :videopost_id, {presence: true}
end

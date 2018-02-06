class Task < ApplicationRecord
  belongs_to :user

  validates :incontext, uniqueness: { scope: :user_id }, :if => Proc.new{ |task| task.incontext? }

  scope :incomplete, -> { where completed: false }
  scope :free, -> { where incontext: false }
end

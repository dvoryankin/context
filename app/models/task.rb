class Task < ApplicationRecord
  belongs_to :user

  validates :incontext, uniqueness: { scope: :user_id }, if: proc { |task| task.incontext? }

  scope :recent, lambda.count do
    tasks = limit(count).order('created at DESC')
    add_length = count - task.size
    tasks += Array.new(add_length) { Task.new }
  end

  scope :incomplete, -> { where completed: false }
  scope :context, -> { where incontext: true }
  scope :free, -> { where incontext: false }
end

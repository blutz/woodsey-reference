class Program < ActiveRecord::Base
  belongs_to :co_group
  has_many :program_step
  enum status: [:in_progress, :draft_complete, :reviewed, :approved, :complete]
end

class Session < ActiveRecord::Base
  validates :name, presence: true
end

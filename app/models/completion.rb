class Completion < ApplicationRecord
  belongs_to :user
  belongs_to :problem
  belongs_to :solution
end

class Classified < ApplicationRecord
  belongs_to :resort
  belongs_to :housing, optional: true
end

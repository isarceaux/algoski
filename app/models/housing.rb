class Housing < ApplicationRecord
  belongs_to :resort
  has_many :classifieds
end

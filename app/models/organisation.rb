class Organisation < ApplicationRecord
  # Associations
   has_many :users

   # Validations
   validates :name, presence: true, length: { minimum: 2 }
   validates :name, uniqueness: true
end

require "reform/form/validation/unique_validator"

module Organisation::Contract
  module DataIntegrity
    include Reform::Form::Module

    # Schema
    property :name, on: :organisation

    # Validations
    validates :name, presence: true, length: { minimum: 2 }
    validates :name, unique: true
  end
end

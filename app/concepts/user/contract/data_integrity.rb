require "reform/form/validation/unique_validator"

module User::Contract
  module DataIntegrity
    include Reform::Form::Module

    # Schema
    property :name, on: :user
    property :email, on: :user

    # Validations
    validates :name, presence: true, length: { minimum: 3 }
    validates :email, unique: true, format: { with: Devise::email_regexp }
  end
end

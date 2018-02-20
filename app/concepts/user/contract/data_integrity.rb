require "reform/form/validation/unique_validator"
require "reform/form/active_model/model_validations"

module User::Contract
  module DataIntegrity
    include Reform::Form::Module

    # Schema
    property :name
    property :email
    property :password

    # Validations
    validates :name, presence: true, length: { minimum: 3 }
    validates :email, unique: true, format: { with: Devise::email_regexp }
    validates :password, presence: true

  end
end

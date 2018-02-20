require "reform/form/validation/unique_validator"
module User::Contract
  class Signup < Reform::Form

    # User Contract
    # -------------------------------------------------------------------------
    include User::Contract::DataIntegrity
    property :subscribe_to_newsletter, virtual: true

    # Contextual validations
    validates :email, presence: true
    validate :email_in_whitelist, if: '!errors.has_key?(:email)'


    # Organisation Contract
    # -------------------------------------------------------------------------
    property :organisation do
      include Organisation::Contract::DataIntegrity
    end

    private

    def email_in_whitelist
      whitelist = %w(a@test.com b@test.com)
      unless whitelist.include? email
        errors.add(:email, "You are not on the whitelist")
      end
    end

    def subscribe_to_newsletter=(value)
      super(value == '1')
    end


  end
end

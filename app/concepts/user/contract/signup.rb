module User::Contract
  class Signup < Reform::Form

    include User::Contract::DataIntegrity

    property :subscribe_to_newsletter, virtual: true
    property :organisation do
      include Organisation::Contract::DataIntegrity
    end

    # Validations
    validates :email, presence: true
    validate :email_in_whitelist


    private

    def email_in_whitelist
      whitelist = %w(a@test.com b@test.com)
      unless whitelist.include? email
        errors.add(:email, "You are not on the whitelist")
      end
    end

    def subscribe_to_newsletter=(value)
      super ActiveRecord::Type::Boolean.new.cast(value)
    end

  end
end

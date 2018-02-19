class User::Signup < Trailblazer::Operation
  class Present < Trailblazer::Operation
    step :instantiate_organisation!
    step :instantiate_user!
    step :build_contract!

    private

    def instantiate_organisation!(options, **)
      options[:organisation] = Organisation.new
    end

    def instantiate_user!(options, organisation:, **)
      options['model'] = User.new(organisation: organisation)
    end


    def build_contract!(options, model:, **)
      options["contract.default"] = User::Contract::Signup.new(model)
    end
  end

  step Nested( Present )
  step Contract::Validate( key: :user )
  step Contract::Persist()

end

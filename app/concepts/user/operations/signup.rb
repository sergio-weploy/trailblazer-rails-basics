class User::Signup < Trailblazer::Operation
  class Present < Trailblazer::Operation
    step :instantiate_user!
    step Contract::Build( constant: User::Contract::Signup ) # step :build_contract!


    private

    def instantiate_user!(options, **)
      user = User.new
      user.organisation = Organisation.new
      options['model'] = user
    end
    # def build_contract!(options, model:, **)
    #   options["contract.default"] = User::Contract::Signup.new(model)
    # end
  end

  step Nested( Present )
  step Contract::Validate( key: :user )

  step Wrap ( MyTransaction ) {
    step :persist!
    step :add_user_to_mailchimp!
    failure :rollback!
  }

  failure :handle_all_wrap_failures!
  success :send_email_to_user!
  success :enroll_in_newsletter!

  private

  def persist!(options, **)
    form = options['contract.default']
    form.sync
    user = form.model
    organisation = user.organisation
    organisation.save!
    user.save!
  end

  def add_user_to_mailchimp!(options, **)
    form = options['contract.default']
    form.errors.add(:base, 'Mailchimp is unavailable')
    true
  end

  def rollback!(options, **)
    raise MyTransaction::Rollback
  end

  def handle_all_wrap_failures!(options, **)
    form = options['contract.default']
    p "Handled wrap failures"
  end

  def send_email_to_user!(options, model:, **)
    p "Email sent to #{model.email}"
  end

  def enroll_in_newsletter!(options, **)
    form = options['contract.default']
    p "Enrolled #{form.email} in newsletter" if form.subscribe_to_newsletter
  end

end

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

  step Wrap -> (*, &block) { ActiveRecord::Base.transaction do block.call end } {
    step :persist!
    step :add_user_to_mailchimp!
  }

  success :send_email_to_user!
  success :enroll_in_newsletter!

  private

  def debug(options, **)
    byebug
  end

  def persist!(options, **)
    form = options['contract.default']
    form.sync
    user = form.model
    organisation = user.organisation

    ActiveRecord::Base.transaction do
      organisation.save!
      user.save!
    end
  end

  def add_user_to_mailchimp!(options, **)
    puts "Posted to Mailchimp"
  end

  def send_email_to_user!(options, model:, **)
    puts "Email sent to #{model.email}"
  end

  def enroll_in_newsletter!(options, **)
    form = options['contract.default']
    puts "Enrolled #{form.email} in newsletter" if form.subscribe_to_newsletter
  end

end

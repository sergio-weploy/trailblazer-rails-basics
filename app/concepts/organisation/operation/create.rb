class Organisation::Create < Trailblazer::Operation
  class Present < Trailblazer::Operation
    step Model(Organisation, :new)
    step Contract::Build( constant: Organisation::Contract::Create )
  end

  step Nested( Present )
  step Contract::Validate( key: :organisation )
  step Contract::Persist( )
  step :set_success_message!

 def set_success_message!(options, model:, **)
   options["result.success_message"] = "New organisation #{model.name}."
 end

end

module Organisation::Contract
  class Create < Reform::Form
    include Organisation::Contract::DataIntegrity
  end
end

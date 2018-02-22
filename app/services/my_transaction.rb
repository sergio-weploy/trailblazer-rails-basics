class MyTransaction
  extend Uber::Callable

  def self.call(options, *)
    result = ActiveRecord::Base.transaction { yield } # yield runs the nested pipe.

    # If correct, yield will return an array with a lot of stuff.  On the first
    # position it will contain if the result is a rignt.
    # i.e
      # result[0] == Pipetree::Railway::Right
      # will determine if the inner pipe was a success or not.
    # There is an issue in the trailblazer repo to potentially improve this
    byebug
    result[0] == Pipetree::Railway::Right
    # return value decides about left or right track!

  rescue MyTransaction::Rollback
    byebug
    return false
  end

  class Rollback < StandardError; end

end

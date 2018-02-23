# Installation

1. Make sure you have ruby-2.4.3 installed
2. Clone the repo.
3. Create a database superuser called `trailblazer-rails-basics`.  Run `createuser trailblazer-rails-basics;` and `ALTER USER myuser WITH SUPERUSER;`
4. Run `rails db:setup`.
5. You should be done!

# The problem to tackle

1. My application has Users and Organizations and a User must belong to an Organization.

A typicall rails implementation of such domain could look like this:

```ruby
class User < ApplicationRecord
  
  # Data integrity validations
  validates :name, presence: true, length: { minimum: 3 }
  validate :email_format_is_correct
  # Password is implicitly required by Devise

  # Associations
  belongs_to :organization

  private
  def email_format_is_correct
    # ....
  end

end

class Organization < ApplicationRecord
  
  # Data integrity validations
  validates :name, presence: true, length: { minimum: 3 }

  # Associations
  has_many :users

end
```

Notice that the models have some validations in place that ensure the data integrity of the records. This means that every single record must comply with those validations.

2. The signup form on my app contains fields from both the User and the Organization.  It requests the user for these fields:

* User name
* User Email
* User Password
* Organisation name
* Would you like to subscribe to a newsletter?

3. The signup form requires some contextual validations (validations that are only required for this form and not at a data integrity level)

* User email is required.
* The user's email must be on a "white list" that is hosted on an external service for the form to be valid (i.e we need to do an external API call to check).


4. If validations errors occur, either from the model validations or the contextual validations, helpful error messages must be displayed in the from (active model style).

5. Side effects
If both records are saved:
* Register user in Mailchimp
* Send email to user
* If user selected to enroll in newsletter, enroll it


6. Data Integrity requirements
If the user or organization fail to save, or if the user is not savid in mailchimp, neither the user or the organisation should be created and no "side effects" should be triggered.


# Branches in this repo
* The `master` branch contains a sample solution to the problem using trail blazer
* The `start-here` branch contains the basic setup for the problem. Branch out of it to test your own implementation.


 


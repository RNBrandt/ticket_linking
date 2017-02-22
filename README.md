This is an exercise that will work with an existing API. The Setup and Usage sections should help you get up and running, then read the short description of our system and the changes we intend to make.

## System Description

This project is a rudimentary ticketing API. The resources include `Account`, `Ticket` and `User`. Each ticket belongs to an account and a user, and can potentially have a relationship with another ticket. In that case, one ticket is an "incident" of another "problem" ticket. An incident can belong to only one problem ticket and a problem ticket can have many incidents.

This ticket to ticket relationship is currently accomplished using a `problem_id` column on the ticket table. When there are multiple tickets created for the same "problem", setting the `problem_id` on a ticket signifies this is another incident of a problem we are already aware of. If the `problem_id` is `nil`, that ticket is its own independent ticket that does not represent an incident of another ticket.

## Your Task

#### Specifications

The Ticket Linking feature we are asking you to implement should allow more generic relations for any ticket. A ticket should be able to be related to any number of other tickets for any arbitrary reason.

In the new system, a ticket has and belongs to many other related tickets. You should be able to call `ticket.related` and get an array of tickets which are related to this ticket. This could be incidents of a problem. This could be tickets that arose by solving another ticket. It could be additional tickets pertaining to one aspect of another ticket. Regardless of the reason, we want a system that can allow for us to associate any number of tickets together in a meaningful way.

#### Acceptance Criteria

- A single ticket should be able to be related to multiple other tickets as well as have multiple other tickets related to it.
- The `Ticket` model should have meaningful associations that efficiently return related tickets.
- Add a route to the API for `/api/v1/tickets/related.json`. This route returns the array of related tickets.

## Example

Suppose a situation where an office needs more paper for the printer. One of the receptionists opens a ticket with their internal Zendesk IT account.

    { id: 1, subject: "We need more printer paper" }

One of the members of IT sees the ticket and orders some more. One day later, the shipping department receives a notice stating that the shipment of paper will be delayed. They create a ticket to discuss the shipping delay and mark it as related to ticket #1.

    { id: 2, subject: "Shipping has been delayed" }

Ticket #2 is not an incident of running out of paper, but it is related to the problem and affecting the solution of acquiring more paper.


## Usage

#### Setup

To set up your system, clone this repository and run the following commands:

    bundle install
    bundle exec rake db:create
    bundle exec rake db:migrate
    bundle exec rake db:seed
    bundle exec rails server


#### Interface

You can obtain an API sitemap by requesting the root route:

    $ curl http://localhost:3000/

    #=> {
      "accounts": "/api/v1/accounts/default.json",
      "tickets": "/api/v1/tickets.json"
    }

We are primarily going to be working with the `tickets` endpoint, which is fully restful:

    $ curl http://localhost:3000/api/v1/tickets.json
    #=> [{"id":1,"account_id":1,"use...

    $ curl -X POST -d "ticket[account_id]=1" http://localhost:3000/api/v1/tickets.json
    #=> {"id":4,"account_id":1,"user_id":null,"subj...

    etc...

More documentation can be found in the controllers themselves.

## Feature Requests

If you have the time and interest, tackle any of the following features after you've finished the ticket linking exercise.

#### Convert Problems and Incidents into Linked Tickets

Now that our ticket linking feature is finished, let's convert our existing relationships to use our new data model. Add or remove columns and tables as needed, but keep any existing functionality intact. ( Meaning all existing associations on the model should still work )

***
#### Find out why the tickets endpoint is slow

We've had reports from our users that the `/api/v1/tickets.json` endpoint is really slow. We've received more of these complaints from our larger scale customers. See if you can find anything that might be able to speed that endpoint up.

***
#### Include metadata with all API responses

Right now our presenters are currently returning raw data. We would like to include the requested url as meta data with the response. To do this, we want all API responses to be a hash, with the presented data under the `data` key and the requested url in the `url` key.

*Example:*

    # /api/v1/tickets.json
    => [{ "id": 1, "subject": "I'm having a problem!"}]

Would instead return:

    # /api/v1/tickets.json
    => {
          "data": [{ "id": 1, "subject": "I'm having a problem!"}],
          "url": "/api/v1/tickets.json"
        }



***
#### Include the related ticket ids

If a ticket has related tickets, the ticket payload should include a `related_ids` key which is a nested array of the requested ticket's related tickets' ids.

*Example:*

    # /api/v1/tickets/3.json
    => {
          "account_id": 1,
          "body": "Lorem ipsum dolor sit amet, consectetur adipisicing elit",
          "created_at": "2015-11-30T23:53:22.304Z",
          "id": 3,
          "subject": "I'm having an incident!",
          "updated_at": "2015-12-01T20:59:39.045Z",
          "user_id": 1,
          "related_ids": [1,5,6]
       }



***
#### Add API Token authentication

Our ticketing API is currently open to the public without any form of authentication. We want to allow for API requests to be authenticated and scope a user's requests to only be able to see tickets to which their API key authorizes. This means every user should have an API key and each request will be required to provide a valid key. If the key they provide is not valid, they should receive an `401 UNAUTHORIZED` response.


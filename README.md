Grape::ResourceDefinition
=========================

Based on Praxis principle, that design and implementation should be separated, I've created this gem to add the possibility to define the params validation & coercion outside the route's class.

If you are using Grape to create a Blog API (of course), you should have something like this:

    class Posts < Grape::API
    
      desc 'Get all blog posts',
        http_codes: [
          [200, 'Ok']
        ]

      params do
        optional :q, type: Hash
        optional :order_by, type: String
        optional :order_dir, type: String
      end
      
      get '/posts' do
        # Logic to get those posts
      end
      
    end

If your Posts API have only this route, to get all posts, it's ok. But if you have all actions to CRUD your posts, and some more to handle your specific business logic, this will become a mess... for sure.

This was a problem for me. I like my code to be as readable as possible and, with all these documentation and params definition that we need to create ou API, this is not possible.

## Installation

Add this line to your application's Gemfile:

    gem 'grape-resource-definition'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install grape-resource-definition


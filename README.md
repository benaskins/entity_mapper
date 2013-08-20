# EntityMapper

An implementation of the repository pattern inspired by fredwu/datamappify

The main difference between entity_mapper and datamappify is that EntityMapper::Repository will not attempt to automatically map all of your entities attributes to the underlying datasource. The mapping between entities and models must be explicitly defined in the repository.

Other key differences:
* only support ActiveRecord as the underlying datasource
* no support for associations in entities
* no support for a one to many mapping between entities and models
* allow entities to use all features of virtus without effecting the repository's ability to persist
* entities should never have knowledge of the underlying repository (no lazy-loading)
* extremely immature and therefore not nearly as feature rich :)

TODO:
- [ ] tests!!!
- [ ] examples
- [x] repository mapping DSL to replace map_entity_to_model and map_model_to_entity
- [ ] repository hooks


## Installation

Add this line to your application's Gemfile:

    gem 'entity_mapper', :github => 'benaskins/entity_mapper'

And then execute:

    $ bundle

I'll move it to rubygems when the API is stable.


## Usage

### Entities

Pretty much just virtus objects with ActiveModel support:

```ruby
class Quote
  include EntityMapper::Entity

  attribute :departs_on, Date
  attribute :returns_on, Date
  attribute :num_travellers, Integer
  attribute :policy_holder, PolicyHolder
  attribute :ratings, Array[Rating]

  validates :departs_on, :presence => true
  validates :returns_on, :presence => true
end

quote = Quote.new(:departs_on => Date.today, :returns_on => Date.today + 7)
```

### Repositories

Maps your entities to activerecord models:

```ruby
class QuoteRepository
  include EntityMapper::Repository

  class DataStore < ActiveRecord::Base
    self.table_name = 'quotes'
  end

  self.entity_class = Quote

  map :departs_on
  map :returns_on
end


quote = Quote.new(:departs_on => Date.today, :returns_on => Date.today + 7)
QuoteRepository.save(quote)

QuoteRepository.find(quote.id)
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

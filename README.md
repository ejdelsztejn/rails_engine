# Rails Engine

This application is the backend portion of the (Rails Engine)[https://backend.turing.io/module3/projects/rails_engine/] project for the (Turing School of Software and Design)[turing.io].

## Versions
Ruby 2.5.3
Rails 5.2.4.3

## Setup
`$ git clone git@github.com:ejdelsztejn/rails-engine.git`

## Configuration
`$ bundle`
`$ rails g rspec:install`

## Database Setup
`$ bundle exec rails db:create`
`$ bundle exec rails db:migrate`
`$ bundle exec rake csv_import:destroy_data`
`$ bundle exec rake csv_import:seed_data`

## Testing
`$ bundle exec rspec`

### Schema Design

<img width="747" alt="Schema Design" src="https://user-images.githubusercontent.com/43380627/92115086-ea14f580-edbf-11ea-8dd7-1c756e267024.png">


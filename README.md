# TDD Practice with RSpec
## Specs for model validations

### Pre-requisites
 - After pulling repo, run **bundle install**
 - Change the name of /config/application.yml.example to **application.yml**
 - You need to install docker, after installing docker, run mysql docker containers using this command **docker-compose up -d**
 - Run migration **rails db:migrate**
 
### Run test specs
#### Test User model validations by running this command
 ~~~ 
 rspec spec/models/user_spec.rb
 ~~~

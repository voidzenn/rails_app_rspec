# TDD Practice with RSpec

### Pre-requisites
 - After pulling repo, run **bundle install**
 - Change the name of /config/application.yml.example to **application.yml**
 - You need to install docker, after installing docker, run mysql docker containers using this command **docker-compose up -d**
 - Run migration **rails db:migrate**
 
## Model Specs
#### Test User model validations
 ~~~ 
 rspec spec/models/user_spec.rb
 ~~~
#### Test Role model validations
 ~~~ 
 rspec spec/models/role_spec.rb
 ~~~
 ## Controller Specs
 
#### Test Roles Controller
  ~~~ 
 rspec spec/controllers/api/v1/roles_controller_spec.rb
 ~~~
#### Test Users Controller
  ~~~ 
 rspec spec/controllers/api/v1/users_controller_spec.rb
 ~~~

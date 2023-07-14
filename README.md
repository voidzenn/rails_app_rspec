# TDD Practice with RSpec

### Pre-requisites
 - After pulling repo, run **bundle install**
 - Change the name of /config/application.yml.example to **application.yml**
 - You need to install docker, after installing docker, run mysql docker containers using this command **docker-compose up -d**
 - Run migration **rails db:migrate**
 
## Model Specs
#### User
 ~~~ ruby
 rspec spec/models/user_spec.rb
 ~~~
#### Role
 ~~~ ruby
 rspec spec/models/role_spec.rb
 ~~~
#### Post
 ~~~ ruby
 rspec spec/models/post_spec.rb
 ~~~
 ## Controller Specs
 
#### Roles
  ~~~ ruby 
 rspec spec/controllers/api/v1/roles_controller_spec.rb
 ~~~
#### Users
  ~~~ ruby 
 rspec spec/controllers/api/v1/users_controller_spec.rb
 ~~~
#### Posts
  ~~~ ruby 
 rspec spec/controllers/api/v1/posts_controller_spec.rb
 ~~~

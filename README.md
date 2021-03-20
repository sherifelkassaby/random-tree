# README
This is a API bases simple app, on the root URL of this app it will call a service on Heroku to generate random tree then saves it in database. as a response it will provide json format drawn tree.

* Ruby version
  2.7.2
* Rails version
  6.1.1
* System dependencies
  PostgreSQL server
* Configuration
  Currently there is only development environment.
  the app is expecting some environment variables, please check the .env.example
   
* Steps to run the app
  - assuming that the previous points is covered already
  - clone the repo
  - copy .env.example into .env and change the variable according to your development machine, some comments are added there to explain what are the uses.
  - install bundler if not installed then run bundle install.
  - rake db:create
  - rake db:migrate
  - rake db:test:prepare
  - now you can run the server with rails s
   


* API documentation

  

* Improvement points ( To-Do list )
  - Cover with unit test ( APIs, Services, Models )
  - Staging/Production environment
  - Server logs and rotation/archiving for it
  - Database backups
  - CI/CD  
  - SSL certificate
  - Proper API documentation with all valid scenarios
  
  

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
There are 3 APIS, all of them are GET requests and not expecting a parameter from you.

  - **Create/Generate Random tree Tree**

    https://random-tree-app.herokuapp.com/api/v1/nodes
    This API will call a 3rd party hosted on heroku as well (https://random-tree.herokuapp.com/)
    this will generate a random tree, which will be saved in our database and will be available to be searched on later.
    each new call for this API will result in new tree.
    **response example

    ```
    {
       "success":true,
       "msg":"Created successfully.",
       "id":"1",
       "child":[
          {
             "id":"3517",
             "child":[

             ]
          },
          {
             "id":"6468",
             "child":[
                {
                   "id":"7942",
                   "child":[
                      {
                         "id":"7675",
                         "child":[]
                      },
                    [
                }
             ]
          }
       ]
    }
    ```
  
  - **Get parent node by child id**
    https://random-tree-app.herokuapp.com/api/v1/nodes/1191/find_parent
    This API is expecting the child id to be present in the url as you can see the example "1191"

    **response example**

    ```
      {
       "success":true,
       "msg":"Parent is found successfully.",
       "id":"6257"
      }
    ```

  - **Get child nodes by parent id**
    https://random-tree-app.herokuapp.com/api/v1/nodes/1/find_childs
    This API is expecting the child id to be present in the url as you can see the example "1"

     **response example**

      ```
       {
       "success":true,
       "msg":"Childs are found successfully.",
       "id":"1",
       "childs":[
          [
             {
                "id":"2744"
             },
             {
                "id":"3791"
             },
             {
                "id":"6497"
             },
             {
                "id":"9358"
             },
             {
                "id":"6589"
             },
             {
                "id":"4514"
             }
          ]
       ]
      }
      ```
 
  

* Improvement points ( To-Do list )
  - Cover with unit test ( APIs, Services, Models )
  - Staging/Production environment
  - Server logs and rotation/archiving for it
  - Database backups
  - CI/CD  
  - SSL certificate
  - Proper API documentation with all valid scenarios
  
  

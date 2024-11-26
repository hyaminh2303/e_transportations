# README

## Ruby version: 3.3.5
## Rails version: 7.2.2

## Install and run the app
* step 1: Install gems:
```bundle install```

* step 2: Create database:
```bundle exec rails db:create```

* step 3: Run migration:
```bundle exec rails db:migrate```

* step 4: Start the application:
```bundle exec rails s```

## Run unit test
```bundle exec rspec```


## Access API document
* step 1: start the application:
```bundle exec rails s -p 3010```
* step 2: visit: http://localhost:3010/

## Screen record of the demo:

## Generate API documentation
```rails rswag:specs:swaggerize```

## Additional information of gem list that I added
* 1: `active_model_serializers`: To customize json response for frontend
* 2: `rspec-rails`: For writing unit test
* 3: `rswag`: for creating API document
* 4: `rubocop`: for checking coding style and convention (useful for development)
* 5: `annotate`: for generating database attribute in the model (useful for development)
* 6: `rails-erd`: for creating database diagam (useful for development)
* 7: `pagy`: for pagination
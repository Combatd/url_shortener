# URL Shortener

URL-shortening apps like ours are useful for embedding long URLs in space-constrained messages like tweets.

For now, we'll have to be content with a simple CLI tool,
though we can use the launchy gem to pop open the original URL in a browser.

## Learning Goals
* Be able to create a new Rails project
* Be able to navigate a Rails project using the keyboard
* Be able to change the database using migrations
* Be able to write both database constraints and model-level validations
* Be able to write associations
* Understand the purpose of adding an index to columns in our database

### Phase 0: Setup

``` rails new url_shortener --database=postgresql ```

``` bundle exec rails db:create  ```

### Phase 1: Users

``` bundle exec rails generate migration CreateUsers ``` 

* The users table will have columns for timestamps and email.
* An index for the email column

``` bundle exec rails db:migrate ```

* A user.rb file should be in the app/models folder.
* Uniqueness and presence validations for user model

### Phase 2: ShortenedUrl

#### ShortenedUrl class Methods
* #num_clicks
* #num_uniques
* #num_recent_uniques

### Phase 3: Tracking Visits
* To track how many times a shortened URL has been visited and all the shortened URLs the user has visited, we will need a Visit join table model. 
* This join will link the user visits to specific urls.
* There will be associations connecting Visit, User, and ShortenedUrl.


### Phase 4: Simple Command Line Interface CLI

The CLI will look something like the following:
```
~/repos/appacademy/URLShortener$ rails runner bin/cli

Input your email:
> ned@appacademy.io

What do you want to do?
0. Create shortened URL
1. Visit shortened URL
> 0

Type in your long url
> http://www.appacademy.io

Short url is: Pm6T7vWIhTWfMzLaT02YHQ
Goodbye!

~/repos/appacademy/URLShortener$ rails runner bin/cli

Input your email:
> ned@appacademy.io

What do you want to do?
0. Create shortened URL
1. Visit shortened URL
> 1

Type in the shortened URL
> Pm6T7vWIhTWfMzLaT02YHQ

Launching http://www.appacademy.io ...
Goodbye!

~/repos/appacademy/URLShortener$ rails c
Loading development environment (Rails 3.2.11)
1.9.3-p448 :001 > ShortenedUrl.find_by(short_url: "Pm6T7vWIhTWfMzLaT02YHQ").visits
  ShortenedUrl Load (0.1ms)  SELECT "shortened_urls".* FROM "shortened_urls" WHERE "shortened_urls"."short_url" = 'Pm6T7vWIhTWfMzLaT02YHQ' LIMIT 1
  Visit Load (0.1ms)  SELECT "visits".* FROM "visits" WHERE "visits"."shortened_url_id" = 1
 => [#<Visit id: 1, user_id: 1, shortened_url_id: 1, created_at: "2013-08-18 19:15:55", updated_at: "2013-08-18 19:15:55">]
```

### Phase 5: TagTopic and Tagging
* Users will be able to choose a set of predefined TagTopics for links (news, music, sports, etc.).
* no null, uniqueness constraints, seeding database with TagTopics and Taggings
* tag_topics will have to relate to ShortenedUrl model
* tag_topics should return all of the tag topics for a given url
* The relationship between TagTopic and URL is many-to-many, so make join model like Tagging
* TagTopic#popular_links will return 5 most visited links for that TagTopic along with the number of times each link has been clicked. SQL Query!

### Phase 6: Custom Validations
* Users will be prevented from submitting more than 5 URLs a minute.
* Premium users will have this limit removed!

```ShortenedUrl#no_spamming``` 
```ShortenedUrl#nonpremium_max```
These custom validations are defined in the ShortenedUrl model.
A premium column will be added to the Users table. (Boolean type)
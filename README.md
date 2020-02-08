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

The users table will have columns for timestamps and email.

``` bundle exec rails db:migrate ```

* A user.rb file should be in the app/models folder.
* Uniqueness and presence validations for user model
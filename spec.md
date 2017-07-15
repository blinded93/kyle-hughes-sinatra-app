# Specifications for the Sinatra Assessment

Specs:
- [x] Use Sinatra to build the app
      I used Sinatra to build a recipe sharing app.
- [x] Use ActiveRecord for storing information in a database
      My Sinatra app uses ActiveRecord to store recipes, users and messages.
- [x] Include more than one model class (list of model class names e.g. User, Post, Category)
      There are 3 models: User, Recipe and Message.
- [x] Include at least one has_many relationship (x has_many y e.g. User has_many Posts)
      -User has_many users via friends
      -User has_many messages
      -User has_many recipes      
- [x] Include user accounts
      There are user accounts included.
- [x] Ensure that users can't modify content created by other users
      This app uses helper methods and by making visible only to the owning user, certain elements.
- [x] Include user input validations
      Included in all 3 models, when information is required.  Also validates presence via 'required' keyword in forms.
- [x] Display validation failures to user with error message (example form URL e.g. /posts/new)
      Using the flash gem, feedback is given upon action, both successful and failing actions.
- [x] Your README.md includes a short description, install instructions, a contributors guide and a link to the license for your code

Confirm
- [x] You have a large number of small Git commits
      I was having some trouble starting out with the commits, getting them to sync with Github, but I have the log of these commits in the file 'git-log'.
- [x] Your commit messages are meaningful
      Each commit concisely explains what was done.
- [x] You made the changes in a commit that relate to the commit message
      Each commit, save a few of the last styling commits, were to few files at a time. Usually one or two.
- [x] You don't include changes in a commit that aren't related to the commit message.
      As far as I was aware, this did not happen.

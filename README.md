igra
====

A skeleton Ruby on Rails application for HTML5+JavaScript games

Installation
------------

This application skeleton is a Ruby on Rails application which means you'll need to install Ruby language interpreter and Rails framework.

To install Ruby please check this page: http://www.ruby-lang.org/en/downloads/

After installing both Ruby you should be able to install all the dependencies of the application. Fortunately, it's very simple. Open your console, go to application folder, and enter this command:

    bundle

It should install all the libraries you'll need to use the application. When it's done you should be able to run the application. To do this please open console, go to application folder, and enter this command:

    bundle exec rails server

It should launch the application and make it possible to open it at http://localhost:3000/

Setup
-----

To be able to use all the feature of this application skeleton you should enter some additional information.

* Enter your app name and description in config/locales/en.yml
* To enable Facebook sharing register your application at http://developers.facebook.com/apps and enter your app ID in config/settings.yml
* To enable Twitter sharing enter your login in config/settings.yml
* To enable Google Analytics tracking enter your property ID in config/settings.yml

Deployment
----------

The simplest possible deployment option for this game skeleton is to put it to a free instance of Heroku.

To setup your heroku application please complete steps described at the official Getting Started page (https://devcenter.heroku.com/articles/quickstart) and Rails deployment instructions page (https://devcenter.heroku.com/articles/rails3).
# How to deploy to Heroku

Heroku creates a virtual machine that we can push our code to.
It's a different environment, so there are a few extra steps to configure.

Remember when we installed gems? Heroku doesn't have those!

We need to create a "Gemfile" it's a manifest of all the Ruby gems
Heroku should install.

The Gemfile is just for Ruby gems, external libraries, nothing
we'd require_relative.

```
$ bundle init
```

Then we add our gems to it.

```
# Gemfile
gem "sinatra"
gem "active_record"
```

Once we have a manifest we need to seal it or "lock it". This preserves
the current versions we're using

```
$ bundle
```

# Creating a virtual machine on Heroku.

We need to be logged in.

```
$ heroku login
```

Then we can create a new virtual machine from the command line that will
set up a new remote for our git repo with a master branch.

```
$ heroku create
```

Then we can push our code to Heroku using git.

```
$ git push heroku master
```

Then we can check our running version on Heroku

```
$ heroku open
```

If something breaks and we need to check the server logs on Heroku
we can run

```
$ heroku logs
```

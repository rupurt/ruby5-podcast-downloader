## Ruby5Downloader ##

A simple ruby script to download the old podcasts that are no longer available through itunes

## Setup ##

You will need to make sure you have bundler installed
code(gem install bundler)

Install the necessary dependencies through bundler
code(bundle install)

## Usage ##

The downloader accepts 2 arguments. The episode to start downloading from **-f** and the
episode to finish downloading **-t**. The from episode defaults to 1 if not provided.

So for example if I wanted to download episodes 1 to 10 I would provide:

    ./downloader.rb -t 10

If I enjoyed the podcast so much that I then wanted to download episodes 11 to 20 I would
provide:

    ./downloader.rb -f 11 -t 20

Episodes are saved in the **episodes** directory of the repository

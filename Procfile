web: bundle exec rails server webrick -p $PORT -e $RACK_ENV
worker: bundle exec rake resque:work QUEUE=default
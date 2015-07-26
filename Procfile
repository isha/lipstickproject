web: bundle exec rails server webrick -p $PORT -e $RACK_ENV
worker: env TERM_CHILD=1 RESQUE_TERM_TIMEOUT=6 QUEUES=default bundle exec rake environment resque:work
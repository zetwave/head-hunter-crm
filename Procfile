port        ENV['PORT']     || 80
environment ENV['RACK_ENV'] || 'production'

web: bundle exec puma -t 5:5 -p ${PORT:-80} -e ${RACK_ENV:-production}

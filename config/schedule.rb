# A standard output is recorded in the log file.
# If an error occurs, cron will send mail to you.
set :output, :standard => File.join(path, *%w{log cron.log})
job_type :rake, "cd :path && RAILS_ENV=:environment bundle exec rake :task :output" # workaround for running rake with bundle exec

every 1.hour do
  rake 'headline:fetch'
  rake 'twitter:wash_whale'
end

every 5.minutes do
  command 'touch ' + File.join(path, *%w{tmp restart.txt})
end

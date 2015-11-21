root = '/var/www/devlits.com/findurguide.com/current'
working_directory root
pid "/var/www/devlits.com/findurguide.com/shared/tmp/pids/unicorn.pid"
stderr_path "/var/www/devlits.com/findurguide.com/shared/log/unicorn.log"
stdout_path "/var/www/devlits.com/findurguide.com/shared/log/unicorn.log"

# Port configuration
listen "/var/www/devlits.com/findurguide.com/shared/tmp/sockets/unicorn.sock"
worker_processes 4
timeout 60

# Force the bundler gemfile environment variable to
# reference the capistrano "current" symlink
before_exec do |_|
  ENV["BUNDLE_GEMFILE"] = File.join(root, 'Gemfile')
end

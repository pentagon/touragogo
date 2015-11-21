root = "'/var/www/devlits.com/findurguide.com'"
working_directory root
pid "#{root}/tmp/pids/unicorn.pid"
stderr_path "#{root}/log/unicorn.log"
stdout_path "#{root}/log/unicorn.log"

# Port configuration
listen "/var/www/devlits.com/findurguide.com/shared/tmp/sockets/unicorn.sock"
worker_processes 4
timeout 60

# Force the bundler gemfile environment variable to
# reference the capistrano "current" symlink
before_exec do |_|
  ENV["BUNDLE_GEMFILE"] = File.join(root, 'Gemfile')
end

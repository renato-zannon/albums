task :default => [:run]

task :run do
  ruby "lib/app.rb -p #{ENV["PORT"]} -o #{ENV["IP"]}"
end

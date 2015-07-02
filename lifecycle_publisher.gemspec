Gem::Specification.new do |s|
  s.name = "lifecycle_publisher"
  s.version = "0.0.0"
  s.date = "2015-07-02"
  s.summary = "Lifecyle Publisher"
  s.description = "Publishes ActiveRecord lifecycle events (create, update, destroy) to RabbitMQ"
  s.authors = ["Matthew Gerrior"]
  s.email = "gerrior.matthew@gmail.com"
  s.files = [
    "lib/lifecycle_publisher/publishes_lifecycle_events.rb",
    "lib/lifecycle_publisher.rb"
  ]
  s.homepage = ""
  s.license = "MIT"

  s.add_runtime_dependency 'hutch', '>= 0.14.0'
end

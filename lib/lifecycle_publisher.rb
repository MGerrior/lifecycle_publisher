require File.join('lifecycle_publisher', 'publishes_lifecycle_events.rb')

module LifecyclePublisher
end

ActiveSupport.on_load(:active_record) do
  include LifecyclePublisher::Model
end

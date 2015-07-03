module LifecyclePublisher
  module Model
    def self.included(base)
      base.send(:extend, ClassMethods)
    end

    module ClassMethods
      def publishes_lifecycle_events(options = {})
        self.send :include, InstanceMethods

        lifecycle_events = [:create, :update, :destroy]

        options[:on] ||= lifecycle_events
        options_on = Array(options[:on])

        lifecycle_events.each do |event|
          after_commit "publish_#{ event }".to_sym, on: event if options_on.include?(event)
        end
      end
    end

    module InstanceMethods
      def publish_create
        publish("created", self.attributes)
      end

      def publish_update
        publish("updated", self.previous_changes) if self.previous_changes.any?
      end

      def publish_destroy
        publish("destroyed", self.attributes)
      end

      def publish(event, data = {})
        prefix = defined?(::Rails) ? "#{  Rails.application.class.parent_name }." : ""
        routing_key = "#{ prefix }events.models.#{ self.class.model_name.underscore }.#{ event }"

        Hutch.connect
        Hutch.publish(routing_key, data)
      end
    end
  end
end

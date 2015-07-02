module LifecyclePublisher
  module Model
    def self.included(base)
      base.send(:extend, ClassMethods)
    end

    module ClassMethods
      def publishes_lifecycle_events(options = {})
        self.send :include, InstanceMethods

        after_commit :publish_creation, on: :create
        after_commit :publish_update, on: :update
        after_commit :publish_destruction, on: :destroy
      end
    end

    module InstanceMethods
      def publish_creation
        publish("events.models.#{ self.class.name.underscore }.created", self.attributes)
      end

      def publish_update
        publish("events.models.#{ self.class.name.underscore }.updated", self.previous_changes)
      end

      def publish_destruction
        publish("events.models.#{ self.class.name.underscore }.destroyed", self.attributes)
      end

      def publish(routing_key, data = {})
        Hutch.connect
        Hutch.publish(routing_key, data)
      end
    end
  end
end

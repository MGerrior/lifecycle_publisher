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
        p "A new #{ self.class.name } was created with id: #{ self.id } :)"
      end

      def publish_update
        p "It looks like #{ self.class.name } #{ self.id } was updated :|"
      end

      def publish_destruction
        p "It looks like #{ self.class.name } #{ self.id } was destroyed :("
      end
    end
  end
end

module Mongoid
  class Context

    extend Forwardable

    attr_reader :options

    def_delegators :@mongo_client,
                   :cluster,
                   :database

    def initialize(object = nil, opts = {})
      @object = object
      @options = opts
    end

    def collection(other_object = nil)
      if other_object
        mongo_client[other_object.collection_name || other_object.klass.collection_name]
      else
        mongo_client[@object.collection_name]
      end
    end

    def mongo_client
      @mongo_client ||=
        if options[:client]
          Clients.with_name(opts[:client])
        else
          options ? @object.mongo_client.with(options) : @object.mongo_client
        end
    end
  end
end

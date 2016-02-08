module Mongoid
  class Context

    def initialize(object = nil)
      @write_concern = Mongo::WriteConcern.get(w: 1)#object.write_concern
      @read_preference = Mongo::ServerSelector.get(mode: :primary)#object.read_preference
      @collection = object.collection
      @database = @collection.database
      @object = object
    end

    def collection(other_object = nil)
      other_object ? other_object.collection : @collection
    end
  end
end

class MetaData
  include Mongoid::Document
  include Mongoid::Timestamps

  DATA_TYPES = %w(boolean)


  field :name
  field :data_type

  references_and_referenced_in_many :intrigue_items

  validates :name, :presence => true
  validates :data_type, :presence => true, :inclusion => { :in => DATA_TYPES, :allow_blank => true }

  # TODO: remove when updating to Mongoid 2.0 final
  def intrigue_items
    IntrigueItem.any_in(:meta_datum_ids => [self.id])
  end

  class << self
    def map_ids_and_intrigues(interest = nil)
      map = <<-JS
        function() {
          a = this.meta_datum_ids || []
          k = this.interest
          emit(k, { ids: a });
        }
      JS
      reduce = <<-JS
        function(k, values) {
          out = [];
          values.forEach(function(data) {
            data.ids.forEach(function(id) {
              if (out.indexOf(id) == -1) {
                out = out.concat(id);
              }
            });
          });
          return { ids: out };
        }
      JS
      meta_data_map = IntrigueItem.collection.map_reduce(map, reduce, { :out => "meta_datum_ids_for_intrigues" })
      if interest
        meta_data_map.find({ '_id' => interest }).first
      else
        meta_data_map.find.collect
      end
    end
  end
end

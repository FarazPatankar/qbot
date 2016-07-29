class Line
  include Mongoid::Document
  include Mongoid::Timestamps

  field :channel_id, type: String
  field :channel_name, type: String
end

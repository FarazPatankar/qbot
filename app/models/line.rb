class Line
  include Mongoid::Document
  include Mongoid::Timestamps

  field :channel_id, type: String
  field :channel_name, type: String

  has_and_belongs_to_many :users
end

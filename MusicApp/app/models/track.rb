class Track < ActiveRecord::Base
  belongs_to :album

  has_one :band, through: :album, source: :band
end

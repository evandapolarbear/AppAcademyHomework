# == Schema Information
#
# Table name: companies
#
#  id            :integer          not null, primary key
#  name          :string
#  website       :string
#  market_cap    :float
#  ticker_symbol :string
#  created_at    :datetime
#  updated_at    :datetime
#  exchange_id   :integer
#

class Company < ActiveRecord::Base
  has_many :prices,
    primary_key: :id,
    foreign_key: :company_id,
    class_name: :Price

  belongs_to :exchange,
    primary_key: :id,
    foreign_key: :exchange_id,
    class_name: :Exchange

  has_many :watch_list_items,
    primary_key: :id,
    foreign_key: :company_id,
    class_name: :WatchListItem

  has_many :watch_lists,
    through: :watch_list_items,
    source: :watch_list

  has_many :watchers,
  through: :watch_lists,
  source: :user

  has_one :board,
  primary_key: :id,
  foreign_key: :company_id,
  class_name: :Board
end
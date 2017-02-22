class Account < ActiveRecord::Base
  has_many :tickets
  has_many :users

  def to_param
    slug
  end
end

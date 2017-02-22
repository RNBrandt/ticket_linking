class Ticket < ActiveRecord::Base
  belongs_to :account
  belongs_to :user
  belongs_to :problem, class_name: 'Ticket'

  has_many :incidents, class_name: 'Ticket', foreign_key: :problem_id

  def incident?
    problem_id.present?
  end
end

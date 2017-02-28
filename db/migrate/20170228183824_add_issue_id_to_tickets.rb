class AddIssueIdToTickets < ActiveRecord::Migration
  def change
    add_column :tickets, :issue_id, :integer
  end
end

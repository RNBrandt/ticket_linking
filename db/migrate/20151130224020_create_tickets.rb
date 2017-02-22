class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.integer :account_id
      t.integer :user_id
      t.string  :subject
      t.integer :problem_id
      t.text    :body
      t.timestamps
    end
    add_index :tickets, :account_id
  end
end

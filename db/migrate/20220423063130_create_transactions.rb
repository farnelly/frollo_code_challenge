class CreateTransactions < ActiveRecord::Migration[6.0]
  def change
    create_table :api_transactions do |t|
      t.date   :posted_date
      t.string :currency
      t.float  :amount
      t.string :description
      t.string :transaction_type
      t.string :category

      t.timestamps
    end
  end
end

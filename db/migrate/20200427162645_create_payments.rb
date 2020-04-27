# frozen_string_literal: true

class CreatePayments < ActiveRecord::Migration[6.0]
  def change
    create_table :payments do |t|
      t.references :ticket, foreign_key: true

      t.monetize :cost,     null: false
      t.monetize :discount, null: false
      t.monetize :total,    null: false

      t.timestamps null: false
    end
  end
end

# frozen_string_literal: true

class CreateTickets < ActiveRecord::Migration[6.0]
  def change
    create_table :tickets do |t|
      t.string :plate, index: { unique: true }, null: false
      t.string :code,  index: { unique: true }, null: false

      t.timestamps null: false
    end
  end
end

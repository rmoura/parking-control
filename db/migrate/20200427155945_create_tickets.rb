# frozen_string_literal: true

class CreateTickets < ActiveRecord::Migration[6.0]
  def change
    create_table :tickets do |t|
      enable_extension :citext

      t.citext   :plate,  index: true,             null: false
      t.string   :code,   index: { unique: true }, null: false
      t.datetime :leave_date
      t.integer  :status, default: 0,              null: false

      t.timestamps
    end
  end
end

# frozen_string_literal: true

class DeleteEventsStart < ActiveRecord::Migration[5.2]
  def change
    remove_column :events, :start
  end
end

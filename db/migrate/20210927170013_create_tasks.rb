class CreateTasks < ActiveRecord::Migration[6.0]
  def change
    create_table :tasks do |t|
      t.string :name
      t.datetime :deadline
      t.string :state, index: true
      t.datetime :time_finished
      t.datetime :canceled_at

      t.timestamps
    end
  end
end

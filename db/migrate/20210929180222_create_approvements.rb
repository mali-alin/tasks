class CreateApprovements < ActiveRecord::Migration[6.0]
  def change
    create_table :approvements do |t|
      t.references :task, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end

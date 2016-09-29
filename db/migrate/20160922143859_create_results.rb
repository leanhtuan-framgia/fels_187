class CreateResults < ActiveRecord::Migration[5.0]
  def change
    create_table :results do |t|
      t.boolean :state, default: false
      t.string :multiple_answers
      t.integer :lesson_id
      t.integer :question_id

      t.timestamps
    end
  end
end

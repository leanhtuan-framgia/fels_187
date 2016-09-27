class CreateQuestions < ActiveRecord::Migration[5.0]
  def change
    create_table :questions do |t|
      t.string :content
      t.integer :question_type
      t.references :category, index: true, foreign_key: true
      t.timestamps
    end
  end
end

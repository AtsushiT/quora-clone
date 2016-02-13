class CreateQuestions < ActiveRecord::Migration

  def change
    create_table :questions do |t|
      t.text :question_title
      t.text :question_content
      t.references :user, null: false
      t.timestamp
    end
  end
end

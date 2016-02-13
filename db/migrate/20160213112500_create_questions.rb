class CreateQuestions < ActiveRecord::Migration

  def change
    create_table :questions do |t|
      t.text :question_title
      t.text :question_content
      t.references :user
      # can't put user_id to this column
      t.timestamp
    end
  end

  def down
    drop_table :questions
  end

end

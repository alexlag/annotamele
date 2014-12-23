class CreateQuestions < ActiveRecord::Migration
  def change
    create_table(:questions) do |t|
      t.integer :type_id
      t.string :object
      t.string :context

      t.timestamps
    end
  end
end

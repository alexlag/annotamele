class CreateAnswerTypes < ActiveRecord::Migration
  def change
    create_table :answer_types do |t|
      t.string :type
      t.text :body, default: {}
    end
  end
end

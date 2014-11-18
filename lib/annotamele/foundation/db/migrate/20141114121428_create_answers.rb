class CreateAnswers < ActiveRecord::Migration
  def change
    create_table(:answers) do |t|
      t.references :question
      t.references :user
      Rails.application.config.annotamele_fields.each do |field|
        t.boolean field, default: false, null: false
      end

      t.timestamps
    end
  end
end

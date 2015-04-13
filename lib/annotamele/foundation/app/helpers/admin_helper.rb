module AdminHelper
  def load_types(file)
    answer_types = JSON.parse file.read, symbolize_names: true

    answer_types.each do |at|
      t = at[:name].constantize.new at[:params]
      # Much unsafe. Wow.
      t.id = AnswerType.count
      t.save!
    end
    rescue
      false
  end

  def load_questions(file)
    seed_data = JSON.parse file.read, symbolize_names: true

    seed_data[:questions].each do |sd|
      q = Question.new(
        type_id: sd[:type],
        object: sd[:object],
        context: sd[:context]
      )
      q.save!
    end
    rescue
      false
  end
end

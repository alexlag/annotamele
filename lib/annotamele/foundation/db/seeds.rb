10.times do |i|
  q = Question.new(
    text: "Test text no.#{i}",
    object: "Test object #{i}",
    context: "<b>Test context #{Random.rand(1000..2000)}<b>"
  )
  q.save!
end
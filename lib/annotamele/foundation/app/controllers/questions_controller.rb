class QuestionsController < ApplicationController
  
  def new
  	@question = Question.first || Question.new
  	@answer = Answer.new
  end

  private

  	def question_params 
  	end

end
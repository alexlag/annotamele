class AnswersController < ApplicationController

  def new
    puts answer_params
    redirect_to new_question_path
  end

  private 

  def answer_params
    params.require(:answer).permit(*Rails.application.config.annotamele_fields, :question_id)
  end
end
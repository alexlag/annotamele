class AnswersController < ApplicationController
  before_filter :authenticate_user!

  def question
    @question = Question.random_without(current_user.answered_question_ids).first

    respond_to do |format|
      format.html { render :new }
    end
  end

  def add_answer
    @answer = Answer.new(answer_params)
    @answer.user = current_user || User.anonymous
    @answer.preprocess

    if @answer.save
      redirect_to new_question_path
    else
      redirect_to new_question_path, alert: 'Your answer was not valid'
    end
  end

  def index
    @answers = Answer.includes(:question).all

    render :index, formats: :json
  end

  private

  def answer_params
    params.require(:answer).permit!
  end
end

module Admin
  class ConfigController < Admin::BaseController
    include AdminHelper
    def index
      @questions = Question.all
      @types = AnswerType.all # Rails.application.config.annotamele_types
    end

    def show
    end

    def update_types
      if params[:types_file] && load_types(params[:types_file])
        redirect_to admin_config_path, notice: 'Types were added'
      else
        redirect_to admin_config_path, alert: 'Types were NOT added. Wrong file format?'
      end
    end

    def update_questions
      if params[:questions_file] && load_questions(params[:questions_file])
        redirect_to admin_config_path, notice: 'Questions were added'
      else
        redirect_to admin_config_path, alert: 'Questions were NOT added. Wrong file format?'
      end
    end

    def purge
      Answer.delete_all
      Question.delete_all
      AnswerType.delete_all
      redirect_to admin_config_path, notice: 'All answers, questions and types were deleted'
    end
  end
end

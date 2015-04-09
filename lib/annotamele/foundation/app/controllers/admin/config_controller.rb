module Admin
  class ConfigController < Admin::BaseController
    def index
      @questions = Question.all
      @types = Rails.application.config.annotamele_types
    end

    def show
    end
  end
end

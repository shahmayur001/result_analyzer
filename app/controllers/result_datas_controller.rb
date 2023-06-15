# frozen_string_literal: true

class ResultDatasController < ApplicationController

  def store_data
    @result_data = ResultsData.new(result_params)

    if @result_data.save
      render json: "Result data is successfully stored", status: 200
    else
      render json: "We couldn't store your result in out database", status: 422
    end
  end

  private

  def result_params
    params.require(:result_data).permit(:subject, :timestamp, :marks)
  end
end

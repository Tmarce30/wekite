class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    @possible_dates = []
    for offset in 0..6
      date = (Date.today + offset)
      @possible_dates << [date.strftime("%A, %b %d"), date]
    end
  end
end

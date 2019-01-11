class CoachController < ApplicationController

  def index
    @coaches = Coach.all # TODO: Skip fully booked coaches!
  end
  
  def show
    @coach = Coach.find(coach_params[:id])
    @student = Student.find(session[:student_id])
    @slots = Slot.all_with_availabilities(@coach.availabilities.ids)
  end

  private

  def coach_params
    params.permit(:id)
  end
  
end

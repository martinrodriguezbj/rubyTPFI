class SchedulesController < ApplicationController   
  skip_authorize_resource

    def editSchedule
        authorize! :edit, :editSchedule
        @schedule = Schedule.find(params[:id])
    end

    def updateSchedule
        authorize! :update, :updateSchedule
        @schedule = Schedule.find(params[:id])
        if @schedule.update(schedule_params)
            redirect_to Bank.find(@schedule.bank_id), notice: "Schedule was successfully updated."
        else
            render :editSchedule, status: :unprocessable_entity
        end
    end

    def schedule_params
        params.require(:schedule).permit(:startAttention, :endAttention)
    end

end
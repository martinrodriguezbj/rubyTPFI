class SchedulesController < ApplicationController

    def editSchedule
        #recibir el id del schedule a editar
        @schedule = Schedule.find(params[:id])
    end

    def updateSchedule
        @schedule = Schedule.find(params[:id])
        if @schedule.update(schedule_params)
            #redirigir al banco al que pertenece el schedule
            redirect_to Bank.find(@schedule.bank_id)
        else
            render :editSchedule, status: :unprocessable_entity
        end
    end

    def schedule_params
        params.require(:schedule).permit(:startAttention, :endAttention)
    end

end
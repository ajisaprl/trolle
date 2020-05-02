class TasksController < ApplicationController

	def new
		@task = Task.new
	end

	def create
		@task = Task.new(tasks_params)
		if @task.save
			flash[:notice] = "Task created!"
			redirect_to task_path(@task)
		else
			render 'new'
		end
	end

	def edit
		@task = Task.find(params[:id])
	end

	def update
		@task = Task.find(params[:id])
		if @task.update(tasks_params)
			flash[:notice] = 'Task was successfully updated'
			redirect_to task_path(@task)
		else
			render 'edit'
		end
	end

	def show
		@task = Task.find(params[:id])
	end

	private

	def tasks_params
		params.require(:task).permit(:content)
	end

end
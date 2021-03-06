class TeacherSessionsController < ApplicationController

  def new
    @teacher_session = TeacherSession.new
  end

  def create
    @teacher_session = TeacherSession.new(params[:teacher_session])
    if @teacher_session.save
      flash[:notice] = "Login successful!"
      redirect_to classrooms_path
    else
      flash[:notice] = "Login error! Please try again."
      redirect_to teacher_login_path
    end
  end

  def destroy
    current_teacher_session.destroy
    flash[:notice] = "Logout successful!"
    redirect_to teacher_login_path
  end

end

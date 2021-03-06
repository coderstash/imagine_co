class ApplicationController < ActionController::Base
  protect_from_forgery
  
  helper :all
  helper_method  :current_admin, :current_admin_session, :current_teacher, :current_teacher_session, :current_student, :current_student_session, :super_admin, :super?

  private
  
    def current_student_session
      return @current_student_session if defined?(@current_student_session)
      @current_student_session = StudentSession.find
    end
    
    def current_student
      return @current_student if defined?(@current_student)
      @current_student = current_student_session && current_student_session.record
    end
    
    def require_student
      unless current_student
        # store_location
        flash[:notice] = "You must be logged in to access this page"
        redirect_to new_student_session_url
        return false
      end
    end

    def require_no_student
      if current_student
        # store_location
        flash[:notice] = "You must be logged out to access this page"
        redirect_to root_path
        return false
      end
    end
  
    def current_teacher_session
      return @current_teacher_session if defined?(@current_teacher_session)
      @current_teacher_session = TeacherSession.find
    end

    def current_teacher
      return @current_teacher if defined?(@current_teacher)
      @current_teacher = current_teacher_session && current_teacher_session.record
    end
    
    def require_auth
      unless current_teacher || current_student || current_admin
        # store_location
        flash[:notice] = "You must be logged in to access this page"
        redirect_to root_url
        return false
      end
    end
    
    def require_teacher
      unless current_teacher || current_admin
        # store_location
        flash[:notice] = "You must be logged in to access this page"
        redirect_to new_teacher_session_url
        return false
      end
    end

    def require_no_teacher
      if current_teacher
        # store_location
        flash[:notice] = "You must be logged out to access this page"
        redirect_to root_path
        return false
      end
    end
    
    
    def current_admin_session
      return @current_admin_session if defined?(@current_admin_session)
      @current_admin_session = AdminSession.find
    end

    def current_admin
      return @current_admin if defined?(@current_admin)
      @current_admin = current_admin_session && current_admin_session.record
    end

    def require_admin
      unless current_admin
        flash[:notice] = "You must be logged in to access this page"
        redirect_to new_admin_session_url
        return false
      end
    end

    def require_no_admin
      if current_admin
        flash[:notice] = "You must be logged out to access this page"
        redirect_to root_path
        return false
      end
    end
    
    protected

      def super_admin
        unless super?
          return false
        end
      end

      def super?
        authenticate_or_request_with_http_basic do |username, password|
          username == APP['username'] && password == APP['password']
        end
      end
  
end

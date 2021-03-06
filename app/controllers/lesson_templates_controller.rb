class LessonTemplatesController < ApplicationController
  
  before_filter :require_teacher, :except => [:show]
  
  layout "internal"
  
  def index
    if params[:teacher_id]
      @teacher_templates = current_teacher.lesson_templates.order('created_at desc')
    else
      @templates = LessonTemplate.public_templates.order('created_at desc')
      @account_templates = LessonTemplate.account_templates(current_teacher.account.id)
    end
    
    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /lesson_templates/1
  # GET /lesson_templates/1.xml
  def show
    @lesson_template = LessonTemplate.find(params[:id])
    
    respond_to do |format|
      format.html # show.html.erb
      format.js
    end
  end

  # GET /lesson_templates/new
  # GET /lesson_templates/new.xml
  def new
    @lesson_template = LessonTemplate.new
    @lesson_template.videos.build
    question = @lesson_template.questions.build
    question.answers.build
  
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @lesson_template }
    end
  end

  # GET /lesson_templates/1/edit
  def edit
    @lesson_template = LessonTemplate.find(params[:id])
  end

  # POST /lesson_templates
  # POST /lesson_templates.xml
  def create
    
    @lesson_template = LessonTemplate.new(params[:lesson_template])
    @lesson_template.set_base_ids(current_teacher)
    @lesson_template.set_access_type(params[:access_type])
    
    respond_to do |format|
      if @lesson_template.save
        format.html { redirect_to(lesson_templates_path, :notice => 'Lesson template was successfully created.') }
        format.xml  { render :xml => @lesson_template, :status => :created, :location => @lesson_template }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @lesson_template.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /lesson_templates/1
  # PUT /lesson_templates/1.xml
  def update
    @lesson_template = LessonTemplate.find(params[:id])

    respond_to do |format|
      if @lesson_template.update_attributes(params[:lesson_template])
        format.html { redirect_to(@lesson_template, :notice => 'Lesson template was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @lesson_template.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /lesson_templates/1
  # DELETE /lesson_templates/1.xml
  def destroy
    @lesson_template = LessonTemplate.find(params[:id])
    @lesson_template.destroy

    respond_to do |format|
      format.html { redirect_to(lesson_templates_url) }
      format.xml  { head :ok }
    end
  end
end

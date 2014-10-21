class ActivitiesController < ApplicationController
  before_action :set_activity, only: [:show, :edit, :update, :destroy]
  respond_to :html,:json

  def index
    today = DateTime.now
    from = to_date(params[:from]) || today.yesterday
    to = to_date(params[:to]) || today
    @activities = Activity.where('begin_at >= ? and begin_at < ?', from, to)
    puts "-------"
    p from
    p to
    p @activities
    puts "-------"
    respond_with(@activities)
  end
  def for_day
    date = Time.new(*date_params)
    @activities = Activity.where('begin_at >= ? and begin_at < ?', date, date.tomorrow)
    respond_with(@activities)
  end

  def show
    respond_with(@activity)
  end

  def new
    @activity = Activity.new
    respond_with(@activity)
  end

  def edit
  end

  def create
    @activity = Activity.new(activity_params)
    @activity.save
    respond_with(@activity)
  end

  def update
    @activity.update(activity_params)
    respond_with(@activity)
  end

  def destroy
    @activity.destroy
    respond_with(@activity)
  end


  private
    def set_activity
      @activity = Activity.find(params[:id])
    end

    def activity_params
      params.require(:activity).permit(:title, :begin_at, :end_at, :description, :type_id)
    end

    def date_params
      %w{year month day}.map{|w| params[w]}
    end
    def to_date(str)
      # str
      str ? DateTime.parse(str) : str
    end
end

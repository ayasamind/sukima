class EntriesController < ApplicationController
  before_action :authenticate_user!, except:[:index, :show]

  def index
    if params[:id]
    @user = User.find(params[:id])
    @entries = @user.entries
  else
    @entries = Entry.all
  end
    @entries = @entries.readable_for(current_user).order(posted_at: :desc)#.paginate(page: params[:page], per_page: 5)
  end

  def show
    @entry = Entry.readable_for(current_user).find(params[:id])
    @group = Group.new(user_id: @entry.user_id)
  end

  def new
    @entry = Entry.new(posted_at:Time.current)

  end

  def edit
    @entry = current_user.entries.find(params[:id])
  end

  def create
    @entry = Entry.new(entry_params)
    @entry.author = current_user
    if @entry.save
      redirect_to @entry, notice:"投稿を作成しました"
    else
      render "new"
    end
 end

  def update
    @entry = current_user.entries.find(params[:id])
    @entry.assign_attributes(entry_params)
    if @entry.save
      redirect_to @entry, notice:"投稿を更新しました"
    else
      render "edit"
    end
  end

   def destroy
    @entry = current_user.entries.find(params[:id])
      @entry.destroy
      redirect_to :entries, notice:"投稿を削除しました"
    end


  def search
    @entries = Entry.where(job_category: params[:keyword])
  end

  private
    def entry_params
      binding.pry
      params.require(:entry).permit(:title, :body, :posted_at, :status, :image, :industry, :job_category, :area)
    end

end

class VideosController < ApplicationController

  def new
    @video = Video.new

    find_videos

    respond_to do |format|
      format.html { render :layout => 'application'}
      format.xml  { render :xml => @video }
    end
  end

  def create

    @video = Video.new(params[:video])
    @video.created_by = current_user.id

    if @video.save
      flash[:notice] = 'Your video was successfully added. ' + send_mail(@video)
    else
      flash[:error] = 'I could not add your video. Can you send the link or embed object to support? We will add it for you.'
    end

    redirect_to new_video_path
  end


  def destroy
    @video = Video.find(params[:id])

    if @video.destroy
      flash[:notice] = 'Your video was destroyed.'
    else
      flash[:error] = 'I could not destroy your video. Can you send us a mail with the video title? We will destroy the video for you.'
    end

    redirect_to new_video_path
  end


  private

  def send_mail video
    MediaMailer.deliver_email video, current_user, config
    ""
  rescue
    'However, a mail could not be sent to the users. Sorry about that!'
  end


  def find_videos
    @videos = Video.paginate(:page => params[:page], :per_page => 4, :order => 'id DESC')
  end
end

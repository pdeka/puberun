class MusicsController < ApplicationController

  before_filter :find_music, :only => [:new]


  def new
    @music = Music.new

    respond_to do |format|
      format.html { render :layout => 'application'}
      format.xml  { render :xml => @music }
    end
  end

  def create

    @music = Music.new(params[:music])
    @music.created_by = current_user.id
    @music.music_type = params[:music][:music_type]

    if @music.save
      flash[:notice] = 'Your music was successfully added. ' + send_mail(@music)
    else
      flash[:error] = 'I could not add your music. Can you send the link or embed object to support? We will add it for you.'
    end

    redirect_to new_music_path
  end

  def destroy
    @music = Music.find(params[:id])

    if @music.destroy
      flash[:notice] = 'Your music was destroyed.'
    else
      flash[:error] = 'I could not destroy your music. Can you send us a mail with the music title? We will destroy the photo for you.'
    end

    redirect_to new_music_path
  end


  private

  def send_mail music
    MediaMailer.deliver_email music, current_user, config
    ""
  rescue
    'However, a mail could not be sent to the users. Sorry about that!'
  end

  def find_music

    this_type = params[:music_type]

    if this_type.nil?
      @musics = Music.paginate(:page => params[:page], :per_page => 5, :order => 'id DESC')
    else
      @musics = Music.paginate(:page => params[:page], :per_page => 5, :conditions => ['music_type = ?', "#{this_type}"], :order => 'id DESC')
    end

  end

end

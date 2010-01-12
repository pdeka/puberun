class PhotosController < ApplicationController
    before_filter :login_required

    def new
        @photo = Photo.new

        find_photos

        respond_to do |format|
            format.html { render :layout => 'application'}
            format.xml  { render :xml => @photo }
        end
    end

    def create

        params[:photo][:slideshow]= params[:photo][:link]

        @photo = Photo.new(params[:photo])
        @photo.created_by = current_user.id

        if @photo.save
            flash[:notice] = 'Your photo was successfully added. '+ send_mail(@photo)
        else
            flash[:error] = 'I could not add your photo. Can you send the link or embed object to support? We will add it for you.'
        end

        redirect_to new_photo_path
    end


    def destroy
        @photo = Photo.find(params[:id])

        if @photo.destroy
            flash[:notice] = 'Your photo was destroyed.'
        else
            flash[:error] = 'I could not destroy your photo. Can you send us a mail with the photo title? We will destroy the photo for you.'
        end

        redirect_to new_photo_path
    end


    private

    def send_mail photo
        MediaMailer.deliver_email photo, current_user, config
        ""
    rescue
        'However, a mail could not be sent to the users. Sorry about that!'
    end

    def find_photos
        @photos = Photo.paginate(:page => params[:page], :per_page => 4, :order => 'id DESC')
    end
end

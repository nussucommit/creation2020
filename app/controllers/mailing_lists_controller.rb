class MailingListsController < ApplicationController
  before_action :set_mailing_list, only: [:destroy]
  load_and_authorize_resource

  # GET /mailing_lists
  # GET /mailing_lists.json
  def index
    @mailing_lists = MailingList.all
    @email = @mailing_lists.collect(&:email).join("; ")
  end

  # GET /mailing_lists/new
  def new
    @mailing_list = MailingList.new
    @message = Message.new
  end


  # POST /mailing_lists
  # POST /mailing_lists.json
  def create
    @mailing_list = MailingList.new(mailing_list_params)
    if @mailing_list.save
      redirect_to new_message_path, notice: 'You have subscribed to our Mailing List'
    else
      @message = Message.new
      render template: "messages/new"
    end
  end

  # PATCH/PUT /mailing_lists/1
  # PATCH/PUT /mailing_lists/1.json
  def update
    respond_to do |format|
      if @mailing_list.update(mailing_list_params)
        format.html { redirect_to @mailing_list, notice: 'Mailing list was successfully updated.' }
        format.json { render :show, status: :ok, location: @mailing_list }
      else
        format.html { render :edit }
        format.json { render json: @mailing_list.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /mailing_lists/1
  # DELETE /mailing_lists/1.json
  def destroy
    @mailing_list.destroy
    respond_to do |format|
      format.html { redirect_to mailing_lists_url, notice: 'Mailing list was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_mailing_list
      @mailing_list = MailingList.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def mailing_list_params
      params.require(:mailing_list).permit(:email)
    end
end

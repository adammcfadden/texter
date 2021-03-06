class MessagesController < ApplicationController
  before_action :set_message, only: [:show, :edit, :update, :destroy]
  skip_before_filter :verify_authenticity_token, only: [:inbound_messages]

  # GET /messages
  def index
    @messages = Message.all
  end

  # GET /messages/1
  def show
  end

  # GET /messages/new
  def new
    @message = Message.new
  end

  # GET /messages/1/edit
  def edit
  end

  # POST /messages
  def create
    @message = Message.new(message_params)
    if @message.save
      if @message.to_numbers.length == 1
        flash[:notice] = 'Message Sent!'
      else
        flash[:notice] = 'Messages Sent!'
      end
      redirect_to @message
    else
      render :new
    end
  end

  # PATCH/PUT /messages/1
  def update
    if @message.update(message_params)
      redirect_to @message, notice: 'Message was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /messages/1
  def destroy
    @message.destroy
    redirect_to messages_url, notice: 'Message was successfully destroyed.'
  end

  def inbound_messages
    @inbound_message = Message.new(inbound_message_params)
    if @inbound_message.save
      render plain: "Your message has been received!"
    else
      render plain: "Sorry, this number is not available at this time, please try again later."
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_message
      @message = Message.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def message_params
      params.require(:message).permit(:from, :body, :status, to_numbers_attributes: [:number])
    end

    def inbound_message_params
      {to_numbers_attributes: [number: params[:To]], from: params[:From], body: params[:Body], inbound: true}
    end
end

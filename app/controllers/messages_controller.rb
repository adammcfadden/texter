class MessagesController < ApplicationController
  before_action :set_message, only: [:show, :edit, :update, :destroy]

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
    sent = true
    new_messages = []

    params[:message][:to].each do |message_to|
      new_messages << Message.new(message_params.merge({to: message_to}))
    end

    new_messages.each do |message|
      unless message.send_sms
      end
    end

    if sent
      new_message_params = message_params.merge({to: params[:message][:to]})
      binding.pry
      @message = Message.create(new_message_params)
      if new_messages.length == 1
        flash[:notice] = 'Message Sent!'
      else
        flash[:notice] = 'Messages Sent!'
      end
      redirect_to root_path
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_message
      @message = Message.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def message_params
      params.require(:message).permit(:from, :body, :status)
    end
end

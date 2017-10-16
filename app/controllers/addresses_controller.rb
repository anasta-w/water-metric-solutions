class AddressesController < ApplicationController

  def index
    @user = User.find_by(id: session[:user_id])
    @address = @user.address
  end

  def new
    @address = Address.new()
    @user = User.find_by(id: params[:user_id])
  end

  def create
    @address = Address.new(address_params, :user_id)
    @user = User.find_by(id: params[:user_id])
    @address.user_id = @user.id

    if @address.save
      redirect_to address_path(@user, @address)
    else
      @errors = @address.errors.messages
      render :action => "new"
    end
  end

  def edit
    @user = User.find_by(id: session[:user_id])
    @address = Address.find_by(user_id: @user.id)
  end

  def update
    @user = User.find_by(id: session[:user_id])
    @address = Address.find_by(user_id: @user.id)
    if @address.update_attributes(address_params)
      redirect_to address_path(@user, @address)
    else
      render :action => "edit"
    end
  end

  def show
    @user = User.find_by(id: params[:id])
    @address = Address.find_by(user_id: @user.id)
  end

  def destroy
    @user = User.find_by(id: session[:user_id])
    @address = Address.find_by(user_id: @user.id)
    if @address.destroy
      redirect_to user_path(@user)
    else
      render :action => 'show'
    end
  end


  private

  def address_params
    params.require(:address).permit(
      :address_one,
      :address_two,
      :state,
      :city,
      :post_code)
  end

end

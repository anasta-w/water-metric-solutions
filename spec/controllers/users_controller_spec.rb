require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe "GET new" do
    it "assigns @user" do

      user = User.new
      get :new
      expect(assigns(:user)).to eq (user)

    end
  end

end

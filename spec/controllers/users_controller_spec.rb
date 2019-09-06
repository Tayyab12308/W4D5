require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe "GET #new" do
    it "renders a new form" do
      get(:new)
      expect(response).to render_template(:new)
    end
  end

  describe "POST #create" do

    let!(:user) { create(:user) }
        
    context "Sign up" do
      
      it "valid sign up" do
        post(:create, params: { user: {user_name: 'test', password: 'password' } } )
        expect(User.last.user_name).to eq('test') 
        expect(response).to redirect_to(goals_url)
      end

      it "invalid user_name" do
        post(:create, params: { user: { password: 'password'}})
        expect(response).to render_template(:new)        
      end 

    end
  end
end
require "spec_helper"
require "rack/test"
require_relative '../../app'

describe Application do
  include Rack::Test::Methods
  let(:app) { Application.new }

  context "GET /" do 
    it "returns a 200 ok response" do 
      response = get('/')
      expect(response.status).to eq 200
    end

    it "returns the index view" do
      response = get('/')
      expect(response.body).to include('<input type="submit" value="Sign Up!">')
    end
  end 

  context "GET /sign_up" do
    it "returns a 200 ok response" do 
      response = get('/sign_up')
      expect(response.status).to eq 200
    end
    it "returns the sign-up view" do 
      response = get('/sign_up')
      expect(response.body).to include('<h1> Sign up to Chitter </h1>')
    end
  end

  context "POST /sign-up" do 
    it "returns a 200 ok response" do 
      response = post('/sign_up', email: 'chris@chrismail.com', pass_word: 'alan', username: 'chrissy', full_name: 'christopher chris')
    end 

    it "creates a new user and adds it to the database" do
      user_repo = UserRepository.new
      all_users = user_repo.all

      expect(all_users.length).to eq 5
      expect(all_users[4].username).to eq 'chrissy'
    end
  end 

  context "POST /peep" do 
    it "returns a 200 ok response" do 
        response = post('/peep', content: 'this is a peep', time_created: Time.now, user_id: '2')
        expect(response.status).to eq 200 
    end 

    it "creates a new peep and save it to the peep table" do
        response = post('/peep', content: 'this is a peep', time_created: Time.now, user_id: '2')
        peep_repo = PeepRepository.new
        all_peeps = peep_repo.all
        expect(all_peeps.length).to eq 7 
    end 
  end 


end

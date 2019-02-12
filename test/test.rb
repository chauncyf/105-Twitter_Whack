ENV['APP_ENV'] = 'test'

require_relative '../app.rb'
require 'minitest/autorun'
require 'rack/test'

include Rack::Test::Methods

def app
  Sinatra::Application
end

describe "GET/POST on /person/new" do
  # before do
  #   Person.delete_all
  # end

  it "Should create user" do
    post '/person/new', {
        id: 1,
        name: "paul",
        gender: "male"
    }
    last_response.ok?
    Person.all.last.name.must_equal "paul"
  end
end

describe "GET/POST on /event/new" do
  before do
    Event.delete_all
  end

  it "Should create event" do
    post '/event/new', {
        id: 1,
        name: "event1",
    }
    last_response.ok?
    Event.all.last.name.must_equal "event1"
  end
end

describe "GET/POST on /registration/new" do
  before do
    Registration.delete_all
  end

  it "Should create registration" do
    post '/registration/new', {
        person_id: 1,
        event_id: 1,
    }
    last_response.ok?
    Registration.all.last.person_id.must_equal 1
    Registration.all.last.event_id.must_equal 1
  end
end

describe "can get person's event through registration" do
  before do
    Person.delete_all
    Event.delete_all
    Registration.delete_all

    Person.create(
        id: 1,
        name: 'happy guy',
        )
    Event.create(
        id: 1,
        name: 'coding until midnight',
        )
    Registration.create(
        person_id: 1,
        event_id: 1,
        )
  end
  it "should get event through relation" do
    Person.find(1).events.last.name.must_equal 'coding until midnight'
  end
  it "should get person through relation as well" do
    Event.find(1).people.last.name.must_equal 'happy guy'
  end
end

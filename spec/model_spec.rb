require 'spec_helper'
require 'gerd/model/model'
require 'gerd/exceptions'

describe Gerd::Model::GithubState do

  context "validation" do

    it "should validate good json" do

      content = load_fixture('good_state.json')
    
      state = Gerd::Model::GithubState.from_json(content)
      
    end

    it "Should pull out the organisation" do

        content = load_fixture('good_state.json')
    
        state = Gerd::Model::GithubState.from_json(content)

        expect(state.organisation).to eq "Elevenware"

    end

    it "Should have two teams" do

      content = load_fixture('good_state.json')
    
      state = Gerd::Model::GithubState.from_json(content)

      expect(state.teams.length).to eq 2

    end

    it "Should have three members" do

      content = load_fixture('good_state.json')
    
      state = Gerd::Model::GithubState.from_json(content)

      expect(state.members.length).to eq 3

    end

    it "Should have seven repositories" do

      content = load_fixture('good_state.json')
    
      state = Gerd::Model::GithubState.from_json(content)

      expect(state.repositories.length).to eq 7

    end

    it "should not validate malformed json" do

      content = "{"

      expect {Gerd::Model::GithubState.from_json(content) }.to raise_error Gerd::Exceptions::ValidationException
      
    end

    it "should not validate if no organisation is present" do
      content = {
        "teams" => {},
        "repositories" => {},
        "members" => {}
      }
      

      expect {Gerd::Model::GithubState.new(content) }.to raise_error Gerd::Exceptions::ValidationException
      

    end

    it "should not validate if no team element is present" do
      content = { 
        "organisation" => "test",
        "repositories" => {},
        "members" => {}
      }

     expect {Gerd::Model::GithubState.new(content) }.to raise_error Gerd::Exceptions::ValidationException

    end

    it "should not validate if the team element is not an object" do
      content = { 
        "organisation" => "test",
        "teams" => "a string",
        "repositories" => {},
        "members" => {}
      }

      expect {Gerd::Model::GithubState.new(content) }.to raise_error Gerd::Exceptions::ValidationException

    end

    it "should not validate if no repositories element is present" do
      content = { 
        "organisation" => "test",
        "teams" => {},
        "members" => {}
      }

      expect {Gerd::Model::GithubState.new(content) }.to raise_error Gerd::Exceptions::ValidationException

    end

    it "should not validate if the repositories element is not an object" do
      content = { 
        "organisation" => "test",
        "teams" => {},
        "repositories" => "dve",
        "members" => {}
      }

      expect {Gerd::Model::GithubState.new(content) }.to raise_error Gerd::Exceptions::ValidationException

    end

    it "should not validate if no members element is present" do
      content = { 
        "organisation" => "test",
        "teams" => {},
        "repositories" => {}
      }

      expect {Gerd::Model::GithubState.new(content) }.to raise_error Gerd::Exceptions::ValidationException

    end

    it "should not validate if the members element is not an object" do
      content = { 
        "organisation" => "test",
        "teams" => {},
        "repositories" => {},
        "members" => ""
      }

      expect {Gerd::Model::GithubState.new(content) }.to raise_error Gerd::Exceptions::ValidationException 

    end

  end

end
require 'spec_helper'

describe MoviesController do
  describe 'finding with same director' do
    before :each do
      @fake_results = [mock('movie1'), mock('movie2')]
      @fake_movie = mock('movie1',:director =>'Ridley Scott')
      @fake_movie.stub(:destroy)
    end
    it 'should call the model method that finds movies with same director' do
      Movie.should_receive(:find).with('1').and_return(@fake_movie)
      Movie.should_receive(:find_all_by_director).with('Ridley Scott').and_return(@fake_results)
      post :find_with_same_director, {:id => '1'}
    end
    it 'should select the Similar Movies template for rendering' do
      Movie.stub(:find).and_return(@fake_movie)
      Movie.stub(:find_all_by_director).and_return(@fake_results)
      post :find_with_same_director, {:id => '1'}
      response.should render_template('find_with_same_director')
    end
    it 'should make the find movies with same director results available to that template' do
      Movie.stub(:find).and_return(@fake_movie)
      Movie.stub(:find_all_by_director).and_return(@fake_results)
      post :find_with_same_director, {:id => '1'}
      assigns(:movies).should == @fake_results
    end
    it 'should redirect to home page when movie has no director' do
      movie = mock('movie1', :title=>'Alien', :director=>nil)
      Movie.stub(:find).and_return(movie)
      post :find_with_same_director, {:id => '1'}
      response.should be_redirect
    end;
  end
  describe 'show, edit, create, update and destroy movie' do
    before :each do
      @fake_movie = mock('movie1',:title =>'Casablanca')
    end
    it 'should call the model method to create movie' do
      Movie.should_receive(:create!).and_return(@fake_movie)
      post :create, {:movie => @fake_movie}
    end;
    describe 'valid movies' do
    before :each do
      Movie.should_receive(:find).with('1').and_return(@fake_movie)
    end;
    it 'should call the model method destroy' do
      @fake_movie.should_receive(:destroy)
      post :destroy, {:id => '1'}
    end;
    it 'should call the model method to update movie' do
      @fake_movie.should_receive(:update_attributes!)
      post :update, {:id=> '1', :movie => @fake_movie}
    end;
    it 'should call the model method to update movie' do
      post :show, {:id=> '1', :movie => @fake_movie}
    end;
    it 'should call the model method to update movie' do
      post :edit, {:id=> '1', :movie => @fake_movie}
    end;
    end;
  end
  describe 'show sortable filterable home page' do
    it 'should redirect to sort by title' do
      post :index, {:sort =>'title'}
      response.should be_redirect
    end;
    it 'should redirect to sort by release date' do
      post :index, {:sort =>'release_date'}
      response.should be_redirect
    end;
    it 'should sort by title' do
      session[:sort] = 'title'
      Movie.should_receive(:find_all_by_rating).with([], 
        {:order=>:title}).and_return([mock('movie1'), mock('movie2')])
      post :index, {:sort =>'title'}
    end;
  end;
end
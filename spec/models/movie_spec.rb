require 'spec_helper'

describe Movie do
  describe 'get all ratings' do
    it 'should display all ratings' do
      Movie.all_ratings.count.should == 5
    end;
  end;
end;
  


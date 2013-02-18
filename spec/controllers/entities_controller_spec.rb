require 'spec_helper'

describe EntitiesController do
  describe 'registering Entity by LocalID' do
#    it 'should call the model method that creates LocalID record' do
#      pending "we do not work with local id yet"
#    end
#    it 'should call the model method that creates Entity record that reference LocalID'
#    it 'should select the Entity Details template for rendering'
#    it 'should make the inserted data available to that template'
  end

  describe 'getting the Entity by local Alias' do
    before :each do
      @fake_result = [mock('entity1')]
      @fake_owner = mock('Owner')
      @fake_owner.stub(:id).and_return('1')
      Owner.stub(:first).and_return(@fake_owner)
    end
    
    it 'should call the model method that performs Entity search' do
      LocalIdentity.should_receive(:find_by_alias).with('Sensor 1', '1').
        and_return(@fake_result)
      post :get_by_alias, {:search_terms => 'Sensor 1'}
    end
    it 'should redirect to the Entity page' do
      LocalIdentity.stub(:find_by_alias).and_return(@fake_result)      
      post :get_by_alias, {:search_terms => 'Sensor 1'}
      response.should redirect_to(entity_path(assigns(:entity)))
    end
    it 'should make the Entity search results available to redirected page' do
      LocalIdentity.stub(:find_by_alias).and_return(@fake_result)
      post :get_by_alias, {:search_terms => 'Sensor 1'}
      assigns(:entity).should == @fake_result
    end
  end
end
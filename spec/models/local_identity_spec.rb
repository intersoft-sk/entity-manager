require 'spec_helper'

describe LocalIdentity do
  describe 'searching for an Entity by local Alias by keyword' do
    it 'should search with given local_ID keyword' do      
      LocalIdentity.should_receive(:where).with("local_ID = ? AND owner_id = ?", 'Sensor 1', '1')
      LocalIdentity.find_by_alias('Sensor 1', '1')
    end
  end
end

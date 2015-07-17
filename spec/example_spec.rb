require 'rspec'
require_relative '../model/some_example'

describe 'SomeExample' do

  describe 'on message some_method' do

    it 'should return 15' do
      expect(SomeExample.new.some_method).to be 15
    end

  end

end

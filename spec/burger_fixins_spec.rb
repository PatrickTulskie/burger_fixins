require 'spec_helper'
require 'burger_fixins'
require 'logger'

describe 'burger_fixins' do
  
  before(:all) do
    class TestSettings
      include BurgerFixins
      
      redis_instance Redis.new(:db => 15)
      setting :bacon, :boolean
      setting :lettuce_types, :array
      setting :burger_limit, :integer
      
    end
  end

  before(:each) do
    Redis.new(:db => 15).flushdb
  end

  after(:each) do
    Redis.new(:db => 15).flushdb
  end
  
  it "should save a setting" do
    TestSettings.bacon = true
    Redis.new(:db => 15)['TestSettings:bacon'].should == "true"
  end
  
  it "should retrieve a setting" do
    TestSettings.bacon = true
    TestSettings.bacon.should be_true
  end
  
  it "should answer boolean questions" do
    TestSettings.bacon = true
    TestSettings.bacon?.should == true
  end
  
  it "should not break arrays" do
    TestSettings.lettuce_types = ['foo', 'bar']
    TestSettings.lettuce_types.should == ['foo', 'bar']
  end
  
  it "should not break hashes" do
    TestSettings.lettuce_types = { :type1 => 'iceberg' }
    TestSettings.lettuce_types.should == { :type1 => 'iceberg' }
  end
  
  it "should return proper integers" do
    TestSettings.burger_limit = 20
    TestSettings.burger_limit.should == 20
  end
  
end
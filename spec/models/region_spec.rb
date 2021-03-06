require 'spec_helper'

describe Region do
  before(:each) do
    @r = FactoryGirl.create(:region, :name => 'portland')
    @other_region = FactoryGirl.create(:region, :name => 'chicago')
  end

  describe '#n_recent_scores' do
    it 'should return the most recent n scores' do
      lmx = FactoryGirl.create(:location_machine_xref, :location => FactoryGirl.create(:location, :region => @r))
      one = FactoryGirl.create(:machine_score_xref, :location_machine_xref => lmx, :created_at => '2001-01-01')
      two = FactoryGirl.create(:machine_score_xref, :location_machine_xref => lmx, :created_at => '2001-02-01')
      three = FactoryGirl.create(:machine_score_xref, :location_machine_xref => lmx, :created_at => '2001-03-01')

      @r.n_recent_scores(2).should == [one, two]
    end
  end

  describe '#n_high_rollers' do
    it 'should return the high n rollers' do
      scores = Array.new
      lmx = FactoryGirl.create(:location_machine_xref, :location => FactoryGirl.create(:location, :region => @r))

      3.times {|n| scores << FactoryGirl.create(:machine_score_xref, :location_machine_xref => lmx, :initials => "ssw#{n}")}
      scores << FactoryGirl.create(:machine_score_xref, :location_machine_xref => lmx, :initials => "ssw0")

      @r.n_high_rollers(2).should == {
        "ssw0" => [scores[3], scores[0]],
        "ssw2" => [scores[2]],
      }
    end
  end

  describe '#emailContact' do
    it 'should return a default email address if no users are in region' do
      @r.primary_email_contact.should == 'email_not_found@noemailfound.noemail'
    end
  end

  describe '#machinesless_locations' do
    it 'should return any location without a machine' do
      FactoryGirl.create(:location_machine_xref, :location => FactoryGirl.create(:location, :region => @r))
      FactoryGirl.create(:location_machine_xref, :location => FactoryGirl.create(:location, :region => @r))
      l = FactoryGirl.create(:location, :region => @r)
      l2 = FactoryGirl.create(:location, :region => @r)

      @r.machineless_locations.should == [l, l2]
    end
  end

  describe '#locations_count' do
    it 'should return an int representing the number of locations in the region' do
      FactoryGirl.create(:location, :region => @r)
      FactoryGirl.create(:location, :region => @r)

      @r.locations_count.should == 2
    end
  end

  describe '#machines_count' do
    it 'should return an int representing the number of machines in the region' do
      FactoryGirl.create(:location_machine_xref, :location => FactoryGirl.create(:location, :region => @r))
      FactoryGirl.create(:location_machine_xref, :location => FactoryGirl.create(:location, :region => @r))
      FactoryGirl.create(:location_machine_xref, :location => FactoryGirl.create(:location, :region => @r))
      FactoryGirl.create(:location_machine_xref, :location => FactoryGirl.create(:location, :region => @r))

      FactoryGirl.create(:location_machine_xref, :location => FactoryGirl.create(:location, :region => @other_region))

      @r.machines_count.should == 4
    end
  end
end

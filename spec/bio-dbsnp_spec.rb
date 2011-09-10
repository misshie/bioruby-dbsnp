require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Dbsnp" do
  describe "Bitfield" do

    describe ".parse" do
      context "given a string '050000000009000110000100'" do
        it "returns a new instance of Bio::Dbsnp" do
          obj = Bio::Dbsnp::Bitfield.parse('050000000009000110000100')
          obj.should be_an_instance_of(Bio::Dbsnp::Bitfield)
        end
      end
    end

    describe "#byte_stream" do 
      context "given a string '050000000009000110000100' for .parse" do
        it "returns an array ary[0] == 5" do
          obj = Bio::Dbsnp::Bitfield.parse('050000000009000110000100')
          obj.byte_stream[0].should == 5
        end
      end
    end

    describe "#version" do
      context "given a string '050000000009000110000100' for .parse" do
        it "returns 5" do 
          obj = Bio::Dbsnp::Bitfield.parse('050000000009000110000100')
          obj.version.should == 5
        end
      end
    end

    describe "#variation_class" do
      context "given a string '050000000000000000000200' for .parse" do
        it "returns 'dips'" do
          obj = Bio::Dbsnp::Bitfield.parse('050000000000000000000200')
          obj.variation_class.should == "dips"
        end
      end
    end

  end
end

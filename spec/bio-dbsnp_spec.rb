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

      context "given a string '010000000009000110000100' for .parse" do
        it "raises RuntimeError" do
          str = '010000000009000110000100'
          expect { Bio::Dbsnp::Bitfield.parse(str) }.to raise_error(RuntimeError)
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

    describe "#field" do 
      context "given (1) with a string '050102030405060708090A0B' for .parse" do
        it "returns 0x0201" do
          obj = Bio::Dbsnp::Bitfield.parse('050102030405060708090A0B')
          obj.field(1).should == 0x0201
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
        it "returns ':indel'" do
          obj = Bio::Dbsnp::Bitfield.parse('050000000000000000000200')
          obj.variation_class.should == :indel
        end
      end
    end

    # describe "#resource_link" do
    #   context "given a string '050300000301040400000100' of rs55874132 for .parse" do
    #     it "returns an array containing :threed_structure and :submitter_link_out" do
    #       obj = Bio::Dbsnp::Bitfield.parse('050300000301040400000100')
    #       obj.resource_link.should include(:threed_structure, :submitter_link_out)
    #     end
    #   end
    # end

  end
end

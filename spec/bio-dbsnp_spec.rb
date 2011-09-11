require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Dbsnp" do
  describe "Bitfield" do

    describe ".parse" do
      context "given a string '050000000009000110000100'" do
        it "returns a new instance of Bio::NCBI::Dbsnp" do
          obj = Bio::NCBI::Dbsnp::Bitfield.parse('050000000009000110000100')
          obj.should be_an_instance_of(Bio::NCBI::Dbsnp::Bitfield)
        end
      end

      context "given a string '010000000009000110000100' for .parse" do
        it "raises RuntimeError" do
          str = '010000000009000110000100'
          expect { Bio::NCBI::Dbsnp::Bitfield.parse(str) }.to raise_error(RuntimeError)
        end
      end

    end

    describe "#byte_stream" do 
      context "given a string '050000000009000110000100' for .parse" do
        it "returns an array ary[0] == 5" do
          obj = Bio::NCBI::Dbsnp::Bitfield.parse('050000000009000110000100')
          obj.byte_stream[0].should == 5
        end
      end
    end

    describe "#field" do 
      context "given (1) with a string '050102030405060708090A0B' for .parse" do
        it "returns 0x0201" do
          obj = Bio::NCBI::Dbsnp::Bitfield.parse('050102030405060708090A0B')
          obj.field(1).should == 0x0201
        end
      end
    end

    describe "#version" do
      context "given a string '050000000009000110000100' for .parse" do
        it "returns 5" do 
          obj = Bio::NCBI::Dbsnp::Bitfield.parse('050000000009000110000100')
          obj.version.should == 5
        end
      end
    end

    describe "#variation_class" do
      context "given a string '050000000000000000000200' for .parse" do
        it "returns ':indel'" do
          obj = Bio::NCBI::Dbsnp::Bitfield.parse('050000000000000000000200')
          obj.variation_class.should == :indel
        end
      end
    end

    describe "#bit? (private method)" do
      context "given (0b0010, 0b0010)" do
        it "returns true" do
          obj = Bio::NCBI::Dbsnp::Bitfield.parse('050000000000000000000200')
          obj.__send__(:bit?, 0b0010, 0b0010).should be_true
        end
      end

      context "given (0b0010, 0b0111)" do
        it "returns false" do
          obj = Bio::NCBI::Dbsnp::Bitfield.parse('050000000000000000000200')
          obj.__send__(:bit?, 0b0010, 0b0111).should be_false
        end
      end

      context "given (0b1111, 0b0111)" do
        it "returns true" do
          obj = Bio::NCBI::Dbsnp::Bitfield.parse('050000000000000000000200')
          obj.__send__(:bit?, 0b1111, 0b0111).should be_true
        end
      end
    end

    describe "#resource_link [F1]" do
      context "given a string '050300000301040400000100' of rs55874132 for .parse" do
        it "returns an array containing :threed_structure and :submitter_link_out" do
          obj = Bio::NCBI::Dbsnp::Bitfield.parse('050300000301040400000100')
          obj.resource_link.should include(:threed_structure, :submitter_link_out)
        end
      end
    end

    describe "#gene_function [F2]" do
      context "given a string '050300000301040400000100' of rs55874132 for .parse" do
        it "returns an array containing :reference, :synonymous" do
          obj = Bio::NCBI::Dbsnp::Bitfield.parse('050300000301040400000100')
          obj.gene_function.should include(:reference, :synonymous)
        end
      end
    end

    describe "#mapping [F3]" do
      context "given a string '05_0300_0003_01_04_04_00_00_01_00' of rs55874132 for .parse" do
        it "returns an array containing :reference, :synonymous" do
          obj = Bio::NCBI::Dbsnp::Bitfield.parse('05_0300_0003_01_04_04_00_00_01_00')
          obj.mapping.should include(:weight1)
        end
      end
    end

    describe "#allele_frequency [F4]" do
      context "given a string '05_0300_0003_01_04_04_00_00_01_00' of rs55874132 for .parse" do
        it "returns an array containing :reference, :synonymous" do
          obj = Bio::NCBI::Dbsnp::Bitfield.parse('05_0300_0003_01_04_04_00_00_01_00')
          obj.allele_frequency.should include(:validated)
        end
      end
    end

    # describe "#genotype [F5]" do
    #   context "given a string '05_0300_0003_01_04_04_00_00_01_00' of rs55874132 for .parse" do
    #     it "returns an array containing :reference, :synonymous" do
    #       obj = Bio::NCBI::Dbsnp::Bitfield.parse('05_0300_0003_01_04_04_00_00_01_00')
    #       obj.genotype.should include(:high_density)
    #     end
    #   end
    # end



  end
end

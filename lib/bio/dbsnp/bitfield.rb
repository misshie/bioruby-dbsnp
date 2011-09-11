module Bio
  module Dbsnp

    class Bitfield
      def initialize(byte_stream)
        @byte_stream = byte_stream
        ver = version
        raise "Unsupported bitfield version (ver.#{ver})" unless ver == 5
      end

      attr_reader :byte_stream

      def self.parse(bitfield_str)
        byte_stream = Array.new
        bitfield_str.chars.each_slice(2) do |byte_str|
          byte_stream << Integer("0x#{byte_str.join("")}")
        end
      self.new(byte_stream)
      end

      def field(fnum)
        case fnum
        when 0
          byte_stream[0]
        when 1
          (byte_stream[2] << 8) + byte_stream[1]
        when 2
          (byte_stream[4] << 8) + byte_stream[3]
        else
          byte_stream[fnum + 2]
        end
      end

      # field F0
      def version
        field(0) & 0b0000_1111
      end

      # field F1
      # def resource_link
      #   case byte_stream[
      #   end
      # end

      # field F8
      def variation_class
        case (field(8) & 0b0000_1111)
        when 0b0001
          :snp
        when 0b0010
          :indel
        when 0b0011
          :heterozygous
        when 0b0100
          :microsatellite
        when 0b0101
          :named_variation
        when 0b0110
          :novariation
        when 0b0111
          :mixed_class
        when 0b1000
          :multibase_polymorphism
        else
          raise "Should not happen! Check bitfield verison."
        end
      end
    end

  end
end

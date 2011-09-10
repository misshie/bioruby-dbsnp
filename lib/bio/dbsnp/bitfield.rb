module Bio
  module Dbsnp

    class Bitfield
      def initialize(byte_stream)
        @byte_stream = byte_stream
      end

      attr_reader :byte_stream

      def self.parse(bitfield_str)
        byte_stream = Array.new
        bitfield_str.chars.each_slice(2) do |byte_str|
          byte_stream << Integer("0x#{byte_str.join("")}")
        end
      self.new(byte_stream)
      end

      def version
        @byte_stream[0] & 0b0000_1111
      end

      # field F8
      def variation_class
        case (@byte_stream[10] & 0b0000_1111)
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
          :mized_class
        when 0b1000
          :multibase_polymorphism
        else
          raise "Should not happen! Check encoding verison."
        end
      end
    end

  end
end

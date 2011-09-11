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
        bitfield_str.tr("_","").chars.each_slice(2) do |byte_str|
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
      def resource_link
        res = Array.new
        res << :clinical               if bit? field(1), 0b0100_0000_0000_0000
        res << :precious               if bit? field(1), 0b0010_0000_0000_0000
        res << :provisional_tpa        if bit? field(1), 0b0001_0000_0000_0000
        res << :pubmed_central_article if bit? field(1), 0b0000_1000_0000_0000
        res << :short_read_archive     if bit? field(1), 0b0000_0100_0000_0000
        res << :organism_dblink        if bit? field(1), 0b0000_0010_0000_0000
        res << :mgc_clone              if bit? field(1), 0b0000_0001_0000_0000
        res << :trace_archive          if bit? field(1), 0b0000_0000_1000_0000
        res << :assemby_archive        if bit? field(1), 0b0000_0000_0100_0000
        res << :entrez_geo             if bit? field(1), 0b0000_0000_0010_0000
        res << :peobe_db               if bit? field(1), 0b0000_0000_0001_0000
        res << :entrez_gene            if bit? field(1), 0b0000_0000_0000_1000
        res << :entrez_sts             if bit? field(1), 0b0000_0000_0000_0100
        res << :threed_structure       if bit? field(1), 0b0000_0000_0000_0010
        res << :submitter_link_out     if bit? field(1), 0b0000_0000_0000_0001
        res
      end

      # field F2
      def gene_function
        res = Array.new
        res << :stop_loss                 if bit? field(2), 0b0010_0000_0000_0000
        res << :non_synonymous_frameshift if bit? field(2), 0b0001_0000_0000_0000
        res << :non_synonymous_missense   if bit? field(2), 0b0000_1000_0000_0000
        res << :stop_gain                 if bit? field(2), 0b0000_0100_0000_0000
        res << :reference                 if bit? field(2), 0b0000_0010_0000_0000
        res << :synonymous                if bit? field(2), 0b0000_0001_0000_0000
        res << :utr_3p                    if bit? field(2), 0b0000_0000_1000_0000
        res << :utr_5p                    if bit? field(2), 0b0000_0000_0100_0000
        res << :acceptor_splice_site      if bit? field(2), 0b0000_0000_0010_0000
        res << :donor_splice_site         if bit? field(2), 0b0000_0000_0001_0000
        res << :intron                    if bit? field(2), 0b0000_0000_0000_1000
        res << :gene_region_3p            if bit? field(2), 0b0000_0000_0000_0100
        res << :gene_region_5p            if bit? field(2), 0b0000_0000_0000_0010
        res << :gene_segment              if bit? field(2), 0b0000_0000_0000_0001
        res
      end

      #field F3
      def mapping
        res = Array.new
        res << :other_snp         if bit? field(3), 0b0001_0000
        res << :assembly_conflict if bit? field(3), 0b0000_1000
        res << :assembly_specific if bit? field(3), 0b0000_0100
        res << :weight3           if bit? field(3), 0b0000_0011
        res << :weight2           if bit? field(3), 0b0000_0010
        res << :weight1           if bit? field(3), 0b0000_0001
        res << :unmapped if (field(2) & 0b0000_0011) == 0
        res
      end

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
      
      private

      def bit?(subj, bit)
        if (subj & bit) == bit
          true
        else
          false
        end
      end
    end # class Bitfield

  end # module Dbsnp
end #module Bio

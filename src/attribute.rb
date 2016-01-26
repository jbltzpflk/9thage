class Attribute
	attr_reader :fullstring, :tag, :rest
	@@attribs = ['']
	@@constraints = ['when', 'race', 'mode', 'legal', 'istype']
	@@race_attrs = Set[ :accu, :acst, :ally, :crcr, :dfaq, :dvrs, :gmap, :gmul, :hide, :ilmt, :info, :inhr, 
		:ipts, :ireq, :lnch, :mode, :need, :none, :olmt, :pnam, :prim, :scmp, :sglb, :skip, :smap, :tlmt, 
		:trat, :uldr, :ulmt, :umul, :xbrk, :xmlx ]
	@@ext_unit_attrs = Set[ :clmt, :disc, :equl, :foll, :forc, :hide, :inhx, :lcmp, :lead, :legl, :lglx, :must, 
		:ocat, :race, :reqd, :skip, :slmt, :tcon, :tloc, :umax, :umin ]
	@@local_unit_attrs = Set[ :attr, :auto, :bcst, :boun, :calc, :catg, :clon, :comm, :coun, :dflt, :disp, :dtyp, 
		:icst, :incl, :inhl, :ipts, :mgnt, :mirr, :mult, :name, :note, :only, :ratp, :rmdr, :show, :size, 
		:skip, :spec, :sraw, :sset, :strm, :take, :tmul, :type, :xcmp, :xcst, :xmpt, :zero ]
	@@option_attrs = Set[ :acmp, :allw, :apnd, :base, :bttl, :catg, :chld, :comm, :comp, :cost, :csiz, :dsab, 
		:dtyp, :elim, :enab, :glob, :hide, :ichg, :inho, :invs, :item, :legl, :lglx, :list, :modl, :more, 
		:name, :note, :olgl, :onam, :over, :preq, :prng, :prnt, :rang, :rept, :rsiz, :same, :show, :skip, 
		:slct, :spec, :stat, :stxt, :tabl, :take, :tcst, :type, :uatt, :ucmp, :ucst, :uexp, :unam, :unit, 
		:usiz, :usta, :utyp, :vwst, :xcmp, :xcon, :xcst, :xlat ]
	@@item_attrs = Set[ :asop, :base, :bcst, :bttl, :catg, :comm, :dtwk, :dtyp, :elem, :icnt, :imax, :inhi, 
		:ipri, :irac, :ireg, :irng, :itst, :ityp, :legl, :lglx, :name, :note, :prnt, :skip, :spec, :stat, 
		:stxt, :tcst, :type, :uadd, :user, :xcst, :xtot, :zcln ]
	@@element_attrs = Set[ :base, :bttl, :dtyp, :dupl, :irac, :ireg, :itst, :ityp, :legl, :lglx, :name, :prnt, 
		:skip, :solo, :stat, :stxt, :tcst, :type, :xcat, :xcst ]
	@@tweak_attrs = Set[ :comm, :inht, :invs, :legl, :lglx, :name, :note, :skip, :tcst, :xcst, :zamd, 
		:zbas, :zcst, :zdsb, :zdtp, :zfut, :zhid, :zmor, :zovr, :zprt, :zrng, :zshw, :zspc, :zsta, 
		:zstx, :ztbl, :ztyp, :zunm, :zusz, :zutp ]
	@@all_attrs = Set.new
	[@@race_attrs, @@ext_unit_attrs, @@local_unit_attrs, @@option_attrs, @@item_attrs, 
		@@element_attrs, @@tweak_attrs ].each {|s| @@all_attrs.merge s}

	def load_from_string s
		@fullstring = s
		@tag = s.slice(0...4)
		#p @tag
		@rest = nil
		@rest = s.slice(5..-1) if s.length > 5
		#p @rest
		self
	end

	def to_s
		#@fullstring
		@rest ? "#{@tag}:#{@rest}" : "#{@tag}"
	end

	def to_hash
		{:tag=>@tag, :rest=>@rest}
		@fullstring
	end

	def print
		puts "\t#{@fullstring}"
	end
end
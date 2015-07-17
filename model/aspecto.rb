class Aspecto

	attr_accessor :pointCut
	attr_accessor :adviceBefore
	attr_accessor :adviceAfter

	def apply
		tieneUnAdvice ? aplicarUno : aplicarAmbos
	end

	def tieneUnAdvice
		adviceBefore.nil? || adviceAfter.nil?
	end

	def aplicarUno
		pointCut.alcance.each{|par| 
			if(!adviceBefore.nil?)
				adviceBefore.apply_to(par.clase, par.metodo)
			else
				adviceAfter.apply_to(par.clase, par.metodo)
			end
		}
	end

	def aplicarAmbos
		pointCut.alcance.each{|par| 
			adviceBefore.apply_to(par.clase, par.metodo)
			adviceAfter.apply_to(par.clase, par.metodo)
		}
	end

end
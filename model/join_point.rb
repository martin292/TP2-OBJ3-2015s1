class Join_point

	attr_accessor :alcance

	def initialize(val=nil)
		@mundo = ObjectSpace.each_object(Class)
		@val = val
		filtrar
	end

	def filtrar 
		#Nada
	end

	#----------------------------------------------------------

	#Devuelve el conjunto de clases para las cuales el alcance del join­point o point­cut incluye al menos uno de los métodos que define la clase
	def affected_classes
		@alcance.map{|par| par.clase}.to_set
	end

	#Devuelve un conjunto de pares <clase,selector> para los métodos en el alcance del join­point o point­cut.
	def affected_methods
		@alcance
	end

	#Indica si un método está incluido o no en el alcance del join­point o point­cut.
	def affects_method?(clase, selector)
		@alcance.any?{|par| (par.clase == clase && par.metodo == selector)}
	end

	#---------------------------------------------------------

	def y(join­point)
		point­cut = Join_point.new
		point­cut.alcance = @alcance.select{|par| join­point.affects_method?(par.clase, par.metodo)}
		point­cut
	end

	def o(jp)
		point­cut = Join_point.new

		arrayA = @alcance.select{|par| not jp.affects_method?(par.clase, par.metodo)}
		arrayB = jp.alcance.select{|par| not affects_method?(par.clase, par.metodo)}
		
		point­cut.alcance = arrayA.concat(arrayB)

		point­cut
	end

	def no
		pc = Join_point.new
		pc.alcance = pares.select{|par| not affects_method?(par.clase, par.metodo)}
		pc
	end

	def pares
		@mundo.collect{|c| c.instance_methods(false).collect{|m| Par.new(c,m)}}.flatten
	end
end


#------------------------------------------------------------------------------------------


class ConjuntoDeClases < Join_point
	#Restringir a métodos definidos en una clase, o un conjunto de clases	
	def filtrar
		@alcance = @val.collect{ |c| c.instance_methods(false).collect{|m| Par.new(c,m)}}.flatten
	end
end

class Desendientes < Join_point
	#Restringir a métodos definidos en una clase o cualquiera de sus descendientes
	def filtrar
		aux = @mundo.select{|c| c == @val || c < @val}
		@alcance = aux.collect{ |c| c.instance_methods(false).collect{|m| Par.new(c,m)}}.flatten
	end
end

class ConNombres < Join_point
	#Restringir a métodos de un nombre indicado, o cuyo nombre esté en un conjunto
	def filtrar
		@alcance = @mundo.map{|c| c.instance_methods(false).map{|m| 
			if(m == @val || @val.include?(m)) 
				Par.new(c, m) 
			end}
		}.flatten.compact
	end
end

class ConAridad < Join_point
	#Restringir a métodos con una determinada aridad
	def filtrar
		@alcance =  @mundo.map{|c| c.instance_methods(false).map{|m|
			if(c.instance_method(m).arity == @val) 
				Par.new(c, m) 
			end} 
		}.flatten.compact
	end
end

class ComienzoDeNombre < Join_point
	#Restringir a métodos cuyo nombre empiece de cierta forma
	def filtrar
		@alcance = @mundo.map{|c| c.instance_methods(false).map{|m| 
			if(m.to_s.start_with?(@val))
				Par.new(c,m)
			end}
		}.flatten.compact
	end
end
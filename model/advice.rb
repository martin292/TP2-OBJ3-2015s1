class Advice

	def initialize
		@before = false
		@code = Proc.new{}
	end

	def code(proc)
		@code = proc
	end

	def apply_before
		@before = true
	end

	def apply_after
		@before = false
	end

	def apply_to(clase, metodo)
		if(existeMetodo(clase, metodo))
			m = clase.instance_method(metodo)
			actualizarMetodo(clase, metodo, m)
		end
	end
	
	def actualizarMetodo(clase, metodo, m)
		codigo = @code
		if(@before)
			p = procBefore(clase, metodo, codigo, m)
		  else
		  p = procAfter(clase, metodo, codigo, m)			
		end
		clase.send(:define_method, metodo, p)
	end

	def procBefore(clase, metodo, codigo, m)
		Proc.new{|x| 
			codigo.call([self.method(metodo).receiver, clase, metodo], x) 
			if(m.arity == 0)
				m.bind(self).call()
			else
				m.bind(self).call(x)
			end
		}
	end

	def procAfter(clase, metodo, codigo, m)
		Proc.new{|x| 
			if(m.arity == 0)
				ret = m.bind(self).call()
			else
				ret = m.bind(self).call(x)
			end
			codigo.call([self.method(metodo).receiver, clase, metodo], x)
			ret
		}
	end

	def existeMetodo(clase, metodo)
		clase.method_defined?(metodo)
	end

end

class Punto
	attr_accessor :x
	attr_accessor :y

	def initialize(x, y)
		@x = x
		@y = y
	end

	def shift_left(how_long)
		@x = @x + how_long
	end
end
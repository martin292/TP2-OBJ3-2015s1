class Par
	attr_accessor :clase
    attr_accessor :metodo

    def initialize(clase, metodo)
    	@clase = clase
    	@metodo = metodo
    end

    def ==(par)
    	@clase == par.clase && @metodo == par.metodo
    end
end
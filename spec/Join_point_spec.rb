require 'rspec'
require_relative '../model/join_point.rb'
require_relative '../model/par.rb'
require_relative '../model/advice.rb'

describe 'ConjuntoDeClase' do

  before :each do
    @joinpoint = ConjuntoDeClases.new([Punto, Par])
  end

  describe 'new' do
    it 'Deberia crear un nuevo join_point' do
      expect(@joinpoint.class).to be ConjuntoDeClases
    end
  end
  
  describe 'affected_classes' do
    it 'Deberia retornar las clases afectadas' do
      expect(@joinpoint.affected_classes.include?(Punto)).to be true
      expect(@joinpoint.affected_classes.include?(Par)).to be true
    end
  end

  describe 'affected_methods' do
    it 'Deberia retornar pares (clase,metodo) que estan en el alcance' do
      expect(@joinpoint.affected_methods.any?{|par| par.clase == Punto}).to be true
      expect(@joinpoint.affected_methods.any?{|par| par.clase == Par}).to be true
      expect(@joinpoint.affected_methods.any?{|par| par.metodo == :shift_left}).to be true
    end
  end

  describe 'affects_method?' do
    it 'Deberia indicar si un metodo esta incluido en el alcance' do
      expect(@joinpoint.affects_method?(Punto, :shift_left)).to be true
    end
  end

end

#-------------------------------------------------------------------------------------------------------

describe 'Desendientes' do

  before :each do
    @joinpoint = Desendientes.new(Join_point)
  end

  describe 'new' do
    it 'Deberia crear un nuevo join_point' do
      expect(@joinpoint.class).to be Desendientes
    end
  end
  
  describe 'affected_classes' do
    it 'Deberia retornar las clases afectadas' do
      expect(@joinpoint.affected_classes.include?(Join_point)).to be true
      expect(@joinpoint.affected_classes.include?(Desendientes)).to be true 
      expect(@joinpoint.affected_classes.include?(ConNombres)).to be true
      expect(@joinpoint.affected_classes.include?(ConAridad)).to be true
      expect(@joinpoint.affected_classes.include?(ComienzoDeNombre)).to be true
    end
  end

  describe 'affected_methods' do
    it 'Deberia retornar pares (clase,metodo) que estan en el alcance' do
      expect(@joinpoint.affected_methods.any?{|par| par.clase == Join_point}).to be true
      expect(@joinpoint.affected_methods.any?{|par| par.clase == Desendientes}).to be true
      expect(@joinpoint.affected_methods.any?{|par| par.clase == ConNombres}).to be true
      expect(@joinpoint.affected_methods.any?{|par| par.clase == ConAridad}).to be true
      expect(@joinpoint.affected_methods.any?{|par| par.clase == ComienzoDeNombre}).to be true
      expect(@joinpoint.affected_methods.any?{|par| par.metodo == :filtrar}).to be true
    end
  end

  describe 'affects_method?' do
    it 'Deberia indicar si un metodo esta incluido en el alcance' do
      expect(@joinpoint.affects_method?(Join_point, :filtrar)).to be true
    end
  end

end

#-------------------------------------------------------------------------------------------------------

describe 'ConNombres' do

  before :each do
    @joinpoint = ConNombres.new([:shift_left])
  end

  describe 'new' do
    it 'Deberia crear un nuevo join_point' do
      expect(@joinpoint.class).to be ConNombres
    end
  end
  
  describe 'affected_classes' do
    it 'Deberia retornar las clases afectadas' do
      expect(@joinpoint.affected_classes.include?(Punto)).to be true
    end
  end

  describe 'affected_methods' do
    it 'Deberia retornar pares (clase,metodo) que estan en el alcance' do
      expect(@joinpoint.affected_methods.any?{|par| par.clase == Punto}).to be true
      expect(@joinpoint.affected_methods.any?{|par| par.metodo == :shift_left}).to be true
    end
  end

  describe 'affects_method?' do
    it 'Deberia indicar si un metodo esta incluido en el alcance' do
      expect(@joinpoint.affects_method?(Punto, :shift_left)).to be true
    end
  end

end

#-------------------------------------------------------------------------------------------------------

describe 'ConAridad' do

  before :each do
    @joinpoint = ConAridad.new(1)
  end

  describe 'new' do
    it 'Deberia crear un nuevo join_point' do
      expect(@joinpoint.class).to be ConAridad
    end
  end
  
  describe 'affected_classes' do
    it 'Deberia retornar las clases afectadas' do
      expect(@joinpoint.affected_classes.include?(Punto)).to be true
    end
  end

  describe 'affected_methods' do
    it 'Deberia retornar pares (clase,metodo) que estan en el alcance' do
      expect(@joinpoint.affected_methods.any?{|par| par.clase == Punto}).to be true
      expect(@joinpoint.affected_methods.any?{|par| par.metodo == :shift_left}).to be true
    end
  end

  describe 'affects_method?' do
    it 'Deberia indicar si un metodo esta incluido en el alcance' do
      expect(@joinpoint.affects_method?(Punto, :shift_left)).to be true
    end
  end

end

#-------------------------------------------------------------------------------------------------------

describe 'ComienzoDeNombre' do

  before :each do
    @joinpoint = ComienzoDeNombre.new("shift")
  end

  describe 'new' do
    it 'Deberia crear un nuevo join_point' do
      expect(@joinpoint.class).to be ComienzoDeNombre
    end
  end
  
  describe 'affected_classes' do
    it 'Deberia retornar las clases afectadas' do
      expect(@joinpoint.affected_classes.include?(Punto)).to be true
    end
  end

  describe 'affected_methods' do
    it 'Deberia retornar pares (clase,metodo) que estan en el alcance' do
      expect(@joinpoint.affected_methods.any?{|par| par.clase == Punto}).to be true
      expect(@joinpoint.affected_methods.any?{|par| par.metodo == :shift_left}).to be true
    end
  end

  describe 'affects_method?' do
    it 'Deberia indicar si un metodo esta incluido en el alcance' do
      expect(@joinpoint.affects_method?(Punto, :shift_left)).to be true
    end
  end

end

#-------------------------------------------------------------------------------------------------------

describe 'PointCut' do

  before :each do
    @conjuntoDeClases = ConjuntoDeClases.new([Punto, Par])
    @desendientes     = Desendientes.new(Join_point)
    @conNombre        = ConNombres.new([:shift_left])
    @conAridad        = ConAridad.new(1)
    @comienzoDeNombre = ComienzoDeNombre.new("shift")
  end

  describe 'ConjuntoDeClases' do
    it 'Y ConNombres' do
      pointcut = @conjuntoDeClases.y @conNombre
      pointcut.affects_method?(Punto, :shift_left).should eq true
      pointcut.affected_methods.any?{|par| par.clase == Par}.should eq false
    end
  end

  describe 'Desendientes' do
    it 'O ComienzoDeNombre' do
      pointcut = @desendientes.o @comienzoDeNombre

      pointcut.affects_method?(Punto, :shift_left).should eq true
      pointcut.affects_method?(Join_point, :filtrar).should eq true
    end
  end

  describe 'ConAridad' do
    it 'NO' do
      pointcut = @conAridad.no
      pointcut.affects_method?(Punto, :shift_left).should eq false
    end
  end

end

require 'rspec'
require_relative '../model/aspecto.rb'
require_relative '../model/advice.rb'
require_relative '../model/join_point.rb'
require_relative '../model/par.rb'

describe 'Aspecto' do

	describe 'on message apply' do
    it 'should aplicar el los advice a todos los metodos del pointcut' do
      aspecto = Aspecto.new

      interceptor1 = Advice.new
      interceptor1.code(Proc.new{|data_interception, param_original| puts "Entrando"})
      interceptor1.apply_before

      interceptor2 = Advice.new
      interceptor2.code(Proc.new{|data_interception, param_original| puts "Saliendo"})
      interceptor2.apply_after

      pointcut = ConjuntoDeClases.new([Punto, Par]).y ConNombres.new([:shift_left])

      aspecto.adviceBefore = interceptor1
      aspecto.adviceAfter = interceptor2
      aspecto.pointCut = pointcut

      aspecto.apply

      Punto.new(0,0).shift_left(1)
    end
  end

  describe 'on message apply' do
    it 'should aplicar el los advice a todos los metodos del pointcut' do
      aspecto = Aspecto.new

      interceptor1 = Advice.new
      interceptor1.code(Proc.new{|data_interception, param_original| puts "Entrando"})
      interceptor1.apply_before

      pointcut = ConjuntoDeClases.new([Punto, Par]).y ConNombres.new([:shift_left])

      aspecto.adviceBefore = interceptor1
      aspecto.pointCut = pointcut

      aspecto.apply

      Punto.new(0,0).shift_left(1)
    end
  end

end
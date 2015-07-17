require 'rspec'
require_relative '../model/advice.rb'

describe 'Advice' do
	describe 'on message apply_to' do
    it 'should actualizar el metodo original (1)' do      
      interceptor = Advice.new
      interceptor.code(Proc.new{|data_interception, param_original| 
      	puts "Test 1"
      	data_interception.first.y = 0})
      interceptor.apply_before

      interceptor.apply_to(Punto, :shift_left)

      puntito = Punto.new(5, 3)
      puntito.shift_left(4)

      puntito.y.should eq 0
      puntito.x.should eq 9

      puntito.y = 10
			puntito.shift_left(1)

			puntito.y.should eq 0
      puntito.x.should eq 10    
    end

    it 'should actualizar el metodo original (2)' do
      
      interceptor = Advice.new
      interceptor.code(Proc.new{|data_interception, param_original| puts "Test 2"})
      interceptor.apply_after

      interceptor.apply_to(String, :eql?)

      str = "Hola"
      str.eql?("Chau").should eq false    
    end

    it 'should actualizar el metodo original (3)' do
      
      interceptor = Advice.new
      interceptor.code(Proc.new{|data_interception, param_original| puts "Test 3"})
      interceptor.apply_before

      interceptor.apply_to(String, :instance_of?)

      str = "Hola"
      str.instance_of?(String).should eq true   
    end
  end
end


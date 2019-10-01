# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

#encoding: utf­8

require_relative 'tipo_sorpresa'

module ModeloQytetet

  class Sorpresa
  def initialize(sorpresa, valor, tipo)
    @sorpresa = sorpresa
    @tipo = tipo
    @valor = valor
  end
  
  def sorpresa
    @sorpresa
  end
  
  def tipo
    @tipo
  end
  
  def valor
    @valor
  end
  
  def to_s
    "CARTA\n  Texto: #{@sorpresa} \n  Valor: #{@valor} \n  Tipo: #{@tipo} \n"
  end
end
end
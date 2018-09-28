# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

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
    "Texto: #{@texto} \n Valor: #{@valor} \n Tipo: #{@tipo}"
  end
end

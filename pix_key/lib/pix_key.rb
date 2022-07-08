# frozen_string_literal: true

class PixKey
    def validaCpf(cpf)
        if(not(cpf.match('[0-9]{3}\.?[0-9]{3}\.?[0-9]{3}\-?[0-9]{2}'))) # expressao regular para validar o cpf
            return false
        end
        
        if (cpf.include? '.'  or cpf.include? '-') # tira caracteres nao numericos
            cpf = cpf.gsub! ".", ""
            cpf = cpf.gsub! "-", ""
        end
        
        if cpf == cpf.reverse  # CPF com numeros iguais
            return false
        end
        
        # verificação do primeiro dígito verificador
        soma = 0
        count = 10
        for i in (0..cpf.length()-2-1) 
            soma = soma + (cpf[i].to_i*count)
            i+=1
            count-=1
        end
        
        primeiro_dig = 11-(soma % 11)
        if (primeiro_dig >= 10) 
            primeiro_dig = 0
        end
        
        # verificação do segundo dígito verificador
        soma = 0
        count = 10
        for j in (1..cpf.length()-1-1) 
            soma = soma + (cpf[j].to_i*count)
            j+=1
            count-=1
        end
        
        segundo_dig = 11-(soma%11)
        if (segundo_dig >= 10) 
            segundo_dig = 0
        end
        
        # verifica se o resultado eh igual ao da string fornecida
        if (cpf[9].to_i != primeiro_dig or cpf[10].to_i != segundo_dig) 
            return false
        end
        return true
    end
    
    def validaCnpj(cnpj)
        if(not(cnpj.match('[0-9]{2}\.?[0-9]{3}\.?[0-9]{3}\/?[0-9]{4}\-?[0-9]{2}'))) # expressao regular para validar o cnpj
          return false
        end
        
        if (cnpj.include? '.'  or cnpj.include? '/'  or cnpj.include? '-')
          cnpj = cnpj.gsub! ".", ""
          cnpj = cnpj.gsub! "/", ""
          cnpj = cnpj.gsub! "-", ""
        end
        
        if cnpj == cnpj.reverse  # CNPJ com numeros iguais
          return false
        end
        
        # verificação do primeiro dígito verificador
        soma = 0
        pesos = [5,4,3,2,9,8,7,6,5,4,3,2]
        for i in (0..cnpj.length()-2-1) 
          soma = soma + (cnpj[i].to_i*pesos[i])
        end
        
        primeiro_dig = 11-(soma % 11)
        if (primeiro_dig >= 10) 
            primeiro_dig = 0
        end
        
        # verificação do segundo dígito verificador
        soma = 0
        pesos = [6,5,4,3,2,9,8,7,6,5,4,3,2]
        for j in (0..cnpj.length()-1-1)
            soma = soma + (cnpj[j].to_i*pesos[j])
        end
        
        segundo_dig = 11-(soma % 11)
        if (segundo_dig >= 10) 
            segundo_dig = 0
        end
        
         # verifica se o resultado eh igual ao da string fornecida
        if (cnpj[12].to_i != primeiro_dig or cnpj[13].to_i != segundo_dig)
            return false
        end
        return true 
    end
    
    def validaTelefone(numeroTel) 
        if(not(numeroTel.match('\+[1-9][0-9]\d{1,14}')))
            return false
        end
        return true
    end
      
    def validaEmail(email) 
        if(not(email.match('\w+@\w+\.?\w+'))) 
            return false
        end
        return true
    end
      
    def validaEvp(evp) 
        if(not(evp.match('[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}'))) 
            return false
        end
        return true
    end
end

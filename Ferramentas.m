classdef Ferramentas
    
    methods
           % ----- Retida as linhas vazias das séries lidas do excel
        function dados = LimpaSerie(obj, serie)
            % ENTRADAS
            %   serie -> serie de dados lidos do excel com linhas NaN
            
            % SAÍDAS
            %   dados -> serie de dados sem as linhas NaN 
        
            fim = find(isnan(serie(:))==1, 1, 'first');         % encontra o 1º NaN
            fim = fim - 1;                                      % último dado válido
            if isempty(fim)                                     % se não tem NaN define o próprio vetor
                fim = size(serie(:),1) ;
            end
            
            dados = serie(1:fim);

            varlist = {'obj', 'serie', 'fim'};                  
            clear(varlist{:})
        end
        
        
        % -----
        function dados = EstimaHoras(obj, data)           

            [l]=size(data,1);
            dias = zeros(l,1);
            for j = 1:(l-1) % na planilha há 1 mês a mais
                dias(j,1) = daysdif(data(j), data(j+1));    % qtd de dias em 1 mês
            end

            dados = dias(1:(l-1),1);               % retira a última linha
        end 

    end
    
end

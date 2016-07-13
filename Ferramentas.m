classdef Ferramentas
    
    methods(Static)
        
           % ----- Retida as linhas vazias das s�ries lidas do excel
        function dados = LimpaSerie(serie)
            % ENTRADAS
            %   serie -> serie de dados lidos do excel com linhas NaN
            
            % SA�DAS
            %   dados -> serie de dados sem as linhas NaN 
        
            fim = find(isnan(serie(:))==1, 1, 'first');         % encontra o 1� NaN
            fim = fim - 1;                                      % �ltimo dado v�lido
            if isempty(fim)                                     % se n�o tem NaN define o pr�prio vetor
                fim = size(serie(:),1) ;
            end
            
            dados = serie(1:fim);

            varlist = {'obj', 'serie', 'fim'};                  
            clear(varlist{:})
        end
        
        
        % ----- Estima o n�mero de horas entre dois meses
        function dados = EstimaHoras(data)           

            [l]=size(data,1);
            dias = zeros(l,1);
            for j = 1:(l-1)                                 % na planilha h� 1 m�s a mais
                dias(j,1) = daysdif(data(j), data(j+1));    % qtd de dias em 1 m�s
            end
            dados = dias(1:(l-1),1);                        % retira a �ltima linha
        end
       
	end
    
end

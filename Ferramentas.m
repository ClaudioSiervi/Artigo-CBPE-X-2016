classdef Ferramentas
    
    methods(Static)
        
           % ----- Retida as linhas vazias das séries lidas do excel
        function dados = LimpaSerie(serie)
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
        
        
        % ----- Estima o número de horas entre dois meses
        function dados = EstimaHoras(data)           

            [l]=size(data,1);
            dias = zeros(l,1);
            for j = 1:(l-1)                                 % na planilha há 1 mês a mais
                dias(j,1) = daysdif(data(j), data(j+1));    % qtd de dias em 1 mês
            end
            dados = dias(1:(l-1),1);                        % retira a última linha
        end
       
   
        %------------------------------------------------------------------
       
        
        % ----- Média aritmética simples
        function ma = MediaAritmetica(serie)

            ma = mean(serie(:, 1));
        end
        
        % ----- Média harmônica simples
        function mh = MediaHarmonica(serie)

            mh = harmmean(serie(:, 1));  
        end
        
%         % ----- Média harmônica da potência ponderada pela vazão
%         function mhp = MediaHarmonicaPond(PgerMWmAno,qAno)
% 
%             mhp = (sum(qAno)/sum(qAno./PgerMWmAno));
%         end
        
        % ----- Permanência que ficou acima da média
        function per = FreqAcumulada(serie, media, anos)
            
            per = (sum(serie(:,1) >= media)/anos)*100;
        end
        
        % ------ Desvio dos resíduos ao quadrado
        function dvp = DvpResiduosQuad(serie, media)
            
            dvp = std((serie(:,1) - media).^2);
        end
        
        % ----- Desvio dos resíduos em relação a MA em módulo
        function dvp = DvpResiduosAbs(serie, media)

            dvp = std(abs(serie(:,1) - media));
        end
        
        % ----- Garatia Física
        function gf = GarantiaFisica(media, desc, cint)
            
            gf = media * desc - cint;
        end
    end
    
end

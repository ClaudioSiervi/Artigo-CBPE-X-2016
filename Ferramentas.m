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

%             varlist = {'obj', 'serie', 'fim'};                  
%             clear(varlist{:})
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
       
   
        % -----------------------------------------------------------------
        % ----- Energia média anual (ponderada pelas horas dos mêses)
        function rst = calc_ma_p_gerMWmAno(usina)

            rst = zeros(usina.anos,1);
            for i = 1:usina.anos
                ini = 1 + (i-1)*12;
                fim = i*12;
                rst(i,1) = sum(usina.p_gerMWh(ini:fim,1))./sum(usina.horas(ini:fim,1));      
            end
        end
        
        % ----- Desvio padrão da energia média anual ponderada por hora-mês
        function rst = calc_dvp_p_gerMWmAno(usina)     
            
            rst = zeros(usina.anos,1);
            for i = 1:usina.anos
                ini = 1 + (i-1)*12;
                fim = i*12;
                rst(i,1) = std(usina.p_gerMWh(ini:fim,1)./usina.horas(ini:fim,1));
            end
        end
        
        %------------------------------------------------------------------
        
        % ----- Média aritmética simples
        function ma = MediaAritmetica(serie)

            ma = mean(serie(:, 1));
        end
        
        % ----- Média aritmética ponderada
        function ma = MediaAritPonderada(serie1, serie2)

            ma = sum(serie1(:, 1).*serie2(:, 1))./sum(serie2(:, 1));
        end
        
        % ----- Média harmônica simples
        function mh = MediaHarmonica(serie)

            mh = harmmean(serie(:, 1));  
        end
        
        %----- Média harmônica ponderada pelas horas anuais
        function mhp = MediaHarmPonderada(serie1, serie2)

            mhp = (sum(serie2(:,1))/sum(serie2(:,1)./serie1(:, 1)));
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

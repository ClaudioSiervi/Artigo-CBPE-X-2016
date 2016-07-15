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

%             varlist = {'obj', 'serie', 'fim'};                  
%             clear(varlist{:})
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
       
   
        % -----------------------------------------------------------------
        % ----- Energia m�dia anual (ponderada pelas horas dos m�ses)
        function rst = calc_ma_p_gerMWmAno(usina)

            rst = zeros(usina.anos,1);
            for i = 1:usina.anos
                ini = 1 + (i-1)*12;
                fim = i*12;
                rst(i,1) = sum(usina.p_gerMWh(ini:fim,1))./sum(usina.horas(ini:fim,1));      
            end
        end
        
        % ----- Desvio padr�o da energia m�dia anual ponderada por hora-m�s
        function rst = calc_dvp_p_gerMWmAno(usina)     
            
            rst = zeros(usina.anos,1);
            for i = 1:usina.anos
                ini = 1 + (i-1)*12;
                fim = i*12;
                rst(i,1) = std(usina.p_gerMWh(ini:fim,1)./usina.horas(ini:fim,1));
            end
        end
        
        %------------------------------------------------------------------
        
        % ----- M�dia aritm�tica simples
        function ma = MediaAritmetica(serie)

            ma = mean(serie(:, 1));
        end
        
        % ----- M�dia aritm�tica ponderada
        function ma = MediaAritPonderada(serie1, serie2)

            ma = sum(serie1(:, 1).*serie2(:, 1))./sum(serie2(:, 1));
        end
        
        % ----- M�dia harm�nica simples
        function mh = MediaHarmonica(serie)

            mh = harmmean(serie(:, 1));  
        end
        
        %----- M�dia harm�nica ponderada pelas horas anuais
        function mhp = MediaHarmPonderada(serie1, serie2)

            mhp = (sum(serie2(:,1))/sum(serie2(:,1)./serie1(:, 1)));
        end
        
%         % ----- M�dia harm�nica da pot�ncia ponderada pela vaz�o
%         function mhp = MediaHarmonicaPond(PgerMWmAno,qAno)
% 
%             mhp = (sum(qAno)/sum(qAno./PgerMWmAno));
%         end
        
        % ----- Perman�ncia que ficou acima da m�dia
        function per = FreqAcumulada(serie, media, anos)
            
            per = (sum(serie(:,1) >= media)/anos)*100;
        end
        
        % ------ Desvio dos res�duos ao quadrado
        function dvp = DvpResiduosQuad(serie, media)
            
            dvp = std((serie(:,1) - media).^2);
        end
        
        % ----- Desvio dos res�duos em rela��o a MA em m�dulo
        function dvp = DvpResiduosAbs(serie, media)

            dvp = std(abs(serie(:,1) - media));
        end
        
        % ----- Garatia F�sica
        function gf = GarantiaFisica(media, desc, cint)
            
            gf = media * desc - cint;
        end
    end
    
end

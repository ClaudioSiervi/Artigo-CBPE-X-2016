% Classe Usina Distribu�da
classdef UsinaDistribuida
   
    properties(Constant = true)
        rho = 1000;                             % massa espec�fica da �gua (Kg/m�)
        g = 9.81;                               % m�/s�
    end

    properties
        % ----- Premissas
        nome;         % nome da usina distribu�da
        horas;        % total de horas de cada m�s do hist�rico de vaz�es (horas)
        meses;        % n�mero de observa��es de cada amostra em meses
        anos;         % n�mero de observa��es de cada amostra em anos
        q;            % s�rie hist�rica de vaz�es(m�/s)
        rend;         % rendimento do conjunto turbina-gerador (%)
        hl;           % altura de queda l�quida (m)
        qs;           % vaz�o sanit�ria (m�/s)
        desc;         % descontos = (1-TEIF)*(1-IP)*(1-PerdasEletric) (%)
        c_int;        % consumo interno (MW)
        p_instMW;     % pot�ncia instalada na usina (MW)
        p_instW;      % pot�ncia instalada na usina (W)
        
        % ----- Valores Estimados
        p_estW;             % pot�ncias estimadas a partir do hist�rico de vaz�es (W)
        p_gerW;             % pot�ncias geradas para cada per�odo do hist�rico (W)
        p_gerMW;            % pot�ncias geradas para cada per�odo do hist�rico (MW)
        p_gerMWh;           % pot�ncias geradas para cada per�odo do hist�rico (MWh)
        
        % ----- Estat�sticas    
        ma_p_gerMWmAno ;%= calc_ma_p_gerMWmAno;     % Energia M�dia Anual (ponderada pelas horas do m�s) "MWm = MWh/h" (ini:fim =12)
        dvp_p_gerMWmAno;    % desv. padr�o das pot�ncias m�dias anuais 

        ma_q_ano;
        dvp_q_ano;          % dev. padr�o das vaz�es m�dias anuais
    end
   
    
    methods
        
        % -----
        function obj = UsinaDistribuida()
            %obj.ma_p_gerMWmAno = obj.calc_ma_p_gerMWmAno(obj);
        end
    end
    
    methods(Static)
        
        % ----- energia m�dia anual (ponderada pelas horas do m�s)
        function rst = calc_ma_p_gerMWmAno(usina)

            rst = zeros(usina.anos,1);
            for i = 1:usina.anos
                ini = 1 + (i-1)*12;
                fim = i*12;
                rst(i,1) = sum(usina.p_gerMWh(ini:fim,1))./sum(usina.horas(ini:fim,1));      
            end
        end
        
        % -----
        function rst = calc_dvp_p_gerMWmAno(usina)     
        % desvio padr�o da energia m�dia anual ponderada por hora-m�s
            for i = 1:usina.anos
                ini = 1 + (i-1)*12;
                fim = i*12;
                rst.dvp_p_gerMWmAno(i,1) = std(usina.p_gerMWh(ini:fim,1)./usina.horas(ini:fim,1));
            end
        end
        
        
        % ----- Desvio padr�o das pot�ncias anuais
        function dvp = dvpPgerAno(usina)
            dvp = zeros(usina.anos,1);         
        end
        
        
    end
   
   
end
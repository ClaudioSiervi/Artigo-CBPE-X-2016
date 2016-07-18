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
        horas_anos;
        q;            % s�rie hist�rica de vaz�es(m�/s)
        rend;         % rendimento do conjunto turbina-gerador (%)
        hl;           % altura de queda l�quida (m)
        qs;           % vaz�o sanit�ria (m�/s)
        desc;         % descontos = (1-TEIF)*(1-IP)*(1-PerdasEletric) (%)
        c_int;        % consumo interno (MW)
        p_instMW;     % pot�ncia instalada na usina (MW)
        p_instW;      % pot�ncia instalada na usina (W)
        
        % ----- Valores Estimados
        gf;                 % Garantia F�sica
        p_estW;             % pot�ncias estimadas a partir do hist�rico de vaz�es (W)   "meses"
        p_gerW;             % pot�ncias geradas para cada per�odo do hist�rico (W)      "meses"
        p_gerMW;            % pot�ncias geradas para cada per�odo do hist�rico (MW)     "meses"
        p_gerMWh;           % pot�ncias geradas para cada per�odo do hist�rico (MWh)    "anos"
        p_gerMWmAno;        % Energia M�dia Anual (ponderada pelas horas do m�s) "MWm = MWh/h" (ini:fim =12)
        
        % ----- Estat�sticas    
        
        dvp_p_gerMWmAno;        % desv. padr�o das pot�ncias m�dias anuais 

        ma_q_ano;
        frq_q_ano;              % freq. acumulada de vaz�es acima da m�dia
        dvp_q_ano;              % dev. padr�o das vaz�es m�dias anuais
        
        ma_prt;                 % M�dia aritm�tica igual a calculada pela PRT 463/2009
        mh_prt;
        ma_pph;                 % M�dia Aritm�tica das pot�ncias ponderadas pelas horas dos meses       
        mh_pph;                 % M�dia Harm�nica das pot�ncias ponderadas pelas horas dos meses

    end
   
    
    methods
        
        % -----
        function obj = UsinaDistribuida()
            obj.gf = GarantiaFisica;
        end
    end
    
    methods(Static)
        
        function rst = HorasAnos(usina)
            
            rst = zeros(usina.anos, 1);
            for i = 1:usina.anos
                ini = 1 + (i-1)*12;
                fim = i*12;
                rst(i,1) = 24*sum(usina.horas(ini:fim,1));
            end
        end
        

        
        % ----- Vaz�o m�dia anual
        function rst = calc_ma_qAno(usina)
            
            rst = zeros(usina.anos,1);
            for i=1:usina.anos

                ini = 1 + (i-1)*12;
                fim = i*12;
                rst(i,1)= sum(usina.q(ini:fim,1))/12;      
            end       
        end
        
       % ----- Desvio padr�o da vaz�o m�dia anual
       function rst = calc_dvp_qAno(usina)
           
            rst = zeros(usina.anos,1);
            for i=1:usina.anos

                ini = 1 + (i-1)*12;
                fim = i*12;
                rst(i,1) = std(usina.q(ini:fim,1));    
            end       
       end
        
        
        

       
    end
   
   
end
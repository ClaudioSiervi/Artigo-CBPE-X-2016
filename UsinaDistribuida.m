
% Classe Usina Distribu�da
classdef UsinaDistribuida
   
    properties(Constant = true)
        rho = 1000;                             % massa espec�fica da �gua (Kg/m�)
        g = 9.81;                               % m�/s�
    end

    properties
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
        p_estW;        % pot�ncias estimadas a partir do hist�rico de vaz�es (W)
        p_gerW;        % pot�ncias geradas para cada per�odo do hist�rico (W)
        p_gerMW;      % ""  (MW) W -> MW
        p_gerMWh;     % MW -> MWh
        p_gerMWmAno;   % 

        %*******************  Estat�sticas  ****************
        dvp_p_gerMWmAno;    % desv. padr�o das pot�ncias m�dias anuais 
        dvp_q_Ano;          % dev. padr�o das vaz�es m�dias anuais
        

    end
   
    methods(Static)
        % Desvio padr�o das pot�ncias anuais
        function dvp = dvpPgerAno()
            dvp = zeros(UsinaD.anos,cenarios);         
        end
        
        
    end
   
   
end
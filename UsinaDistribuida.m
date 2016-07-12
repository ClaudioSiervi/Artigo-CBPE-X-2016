
% Classe Usina Distribuída
classdef UsinaDistribuida
   
    properties(Constant = true)
        rho = 1000;                             % massa específica da água (Kg/m³)
        g = 9.81;                               % m³/s²
    end

    properties
        nome;         % nome da usina distribuída
        horas;        % total de horas de cada mês do histórico de vazões (horas)
        meses;        % número de observações de cada amostra em meses
        anos;         % número de observações de cada amostra em anos
        q;            % série histórica de vazões(m³/s)
        rend;         % rendimento do conjunto turbina-gerador (%)
        hl;           % altura de queda líquida (m)
        qs;           % vazão sanitária (m³/s)
        desc;         % descontos = (1-TEIF)*(1-IP)*(1-PerdasEletric) (%)
        c_int;        % consumo interno (MW)
        p_instMW;     % potência instalada na usina (MW)
        p_instW;      % potência instalada na usina (W)
        p_estW;        % potências estimadas a partir do histórico de vazões (W)
        p_gerW;        % potências geradas para cada período do histórico (W)
        p_gerMW;      % ""  (MW) W -> MW
        p_gerMWh;     % MW -> MWh
        p_gerMWmAno;   % 

        %*******************  Estatísticas  ****************
        dvp_p_gerMWmAno;    % desv. padrão das potências médias anuais 
        dvp_q_Ano;          % dev. padrão das vazões médias anuais
        

    end
   
    methods(Static)
        % Desvio padrão das potências anuais
        function dvp = dvpPgerAno()
            dvp = zeros(UsinaD.anos,cenarios);         
        end
        
        
    end
   
   
end
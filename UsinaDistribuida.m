% Classe Usina Distribuída
classdef UsinaDistribuida
   
    properties(Constant = true)
        rho = 1000;                             % massa específica da água (Kg/m³)
        g = 9.81;                               % m³/s²
    end

    properties
        % ----- Premissas
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
        
        % ----- Valores Estimados
        p_estW;             % potências estimadas a partir do histórico de vazões (W)
        p_gerW;             % potências geradas para cada período do histórico (W)
        p_gerMW;            % potências geradas para cada período do histórico (MW)
        p_gerMWh;           % potências geradas para cada período do histórico (MWh)
        
        % ----- Estatísticas    
        ma_p_gerMWmAno ;%= calc_ma_p_gerMWmAno;     % Energia Média Anual (ponderada pelas horas do mês) "MWm = MWh/h" (ini:fim =12)
        dvp_p_gerMWmAno;    % desv. padrão das potências médias anuais 

        ma_q_ano;
        dvp_q_ano;          % dev. padrão das vazões médias anuais
    end
   
    
    methods
        
        % -----
        function obj = UsinaDistribuida()
            %obj.ma_p_gerMWmAno = obj.calc_ma_p_gerMWmAno(obj);
        end
    end
    
    methods(Static)
        
        % ----- energia média anual (ponderada pelas horas do mês)
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
        % desvio padrão da energia média anual ponderada por hora-mês
            for i = 1:usina.anos
                ini = 1 + (i-1)*12;
                fim = i*12;
                rst.dvp_p_gerMWmAno(i,1) = std(usina.p_gerMWh(ini:fim,1)./usina.horas(ini:fim,1));
            end
        end
        
        
        % ----- Desvio padrão das potências anuais
        function dvp = dvpPgerAno(usina)
            dvp = zeros(usina.anos,1);         
        end
        
        
    end
   
   
end
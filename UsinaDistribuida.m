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
        horas_anos;
        q;            % série histórica de vazões(m³/s)
        rend;         % rendimento do conjunto turbina-gerador (%)
        hl;           % altura de queda líquida (m)
        qs;           % vazão sanitária (m³/s)
        desc;         % descontos = (1-TEIF)*(1-IP)*(1-PerdasEletric) (%)
        c_int;        % consumo interno (MW)
        p_instMW;     % potência instalada na usina (MW)
        p_instW;      % potência instalada na usina (W)
        
        % ----- Valores Estimados
        gf;                 % Garantia Física
        p_estW;             % potências estimadas a partir do histórico de vazões (W)   "meses"
        p_gerW;             % potências geradas para cada período do histórico (W)      "meses"
        p_gerMW;            % potências geradas para cada período do histórico (MW)     "meses"
        p_gerMWh;           % potências geradas para cada período do histórico (MWh)    "anos"
        p_gerMWmAno;        % Energia Média Anual (ponderada pelas horas do mês) "MWm = MWh/h" (ini:fim =12)
        
        % ----- Estatísticas    
        
        dvp_p_gerMWmAno;        % desv. padrão das potências médias anuais 

        ma_q_ano;
        frq_q_ano;              % freq. acumulada de vazões acima da média
        dvp_q_ano;              % dev. padrão das vazões médias anuais
        
        ma_prt;                 % Média aritmética igual a calculada pela PRT 463/2009
        mh_prt;
        ma_pph;                 % Média Aritmética das potências ponderadas pelas horas dos meses       
        mh_pph;                 % Média Harmônica das potências ponderadas pelas horas dos meses

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
        

        
        % ----- Vazão média anual
        function rst = calc_ma_qAno(usina)
            
            rst = zeros(usina.anos,1);
            for i=1:usina.anos

                ini = 1 + (i-1)*12;
                fim = i*12;
                rst(i,1)= sum(usina.q(ini:fim,1))/12;      
            end       
        end
        
       % ----- Desvio padrão da vazão média anual
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
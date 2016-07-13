clc; clear all;

u = 6;      % n�mero de usinas

Pch(u) = UsinaDistribuida;
%Pch(1:u).gf = GarantiaFisica;

Dados = ImportaDados;
Frmt = Ferramentas;

for i = 1:u
    
    % leitura e pr� processamento
    Pch(i).nome = strcat('pch', int2str(i));
    Pch(i).horas = Frmt.EstimaHoras(Frmt.LimpaSerie(Dados.horas(:, i)));
    Pch(i).meses = size(Pch(i).horas, 1);
    Pch(i).anos = floor(Pch(i).meses./12);                    
    Pch(i).q = Frmt.LimpaSerie(Dados.vazoes(:, i));
    Pch(i).p_instMW = Dados.premissas(1, i);
    Pch(i).rend = Dados.premissas(2, i);
    Pch(i).hl = Dados.premissas(3, i);
    Pch(i).qs = Dados.premissas(4, i);
    Pch(i).desc = Dados.premissas(11, i);
    Pch(i).c_int = Dados.premissas(13, i);    
    
    % c�lculos
    Pch(i).p_instW = Pch(i).p_instMW * 1000000;                                         % Convers�o MW -> W
    Pch(i).p_estW = Pch(i).rho*Pch(i).g*Pch(i).hl*Pch(i).rend*(Pch(i).q - Pch(i).qs);   % (W)
    Pch(i).p_gerW = min(Pch(i).p_estW, Pch(i).p_instW).*Pch(i).desc;                    % (W)
    Pch(i).p_gerMW = Pch(i).p_gerW./1000000;                                            % W -> MW
    Pch(i).p_gerMWh = Pch(i).p_gerMW .*Pch(i).horas;                                    % MW -> MWh
    Pch(i).p_gerMWmAno = Pch(i).calc_ma_p_gerMWmAno(Pch(i));                            % Energia m�dia anual (ponderada pelas horas do m�s)
    
    % estat�sticas
    Pch(i).dvp_p_gerMWmAno = Pch(i).calc_dvp_p_gerMWmAno(Pch(i));   % Desvio padr�o da energia m�dia anual
    
    Pch(i).ma_q_ano = Pch(i).calc_ma_qAno(Pch(i));                  % Vaz�o m�dia anual
    Pch(i).dvp_q_ano = Pch(i).calc_dvp_qAno(Pch(i));                % Desvio padr�o da vaz�o m�dia anual
    
    Pch(i).ma_prt = Frmt.MediaAritmetica(Pch(i).p_gerMW);           % M�dia Arit. mensal (Pger em MW)
    Pch(i).mh_prt = Frmt.MediaHarmonica(Pch(i).p_gerMW);            % M�dia Harm. mensal (Pger em MW)
   
    Pch(i).ma_pph = Frmt.MediaAritmetica(Pch(i).p_gerMWmAno);       % M�dia Arit. mensal (Pger em MWm)
    Pch(i).mh_pph = Frmt.MediaHarmonica(Pch(i).p_gerMWmAno);        % M�dia Arit. mensal (Pger em MWm)

    Pch(i).gf.ma_prt = Frmt.GarantiaFisica(Pch(i).ma_prt, Pch(i).desc, Pch(i).c_int);
    Pch(i).gf.mh_prt = Frmt.GarantiaFisica(Pch(i).mh_prt, Pch(i).desc, Pch(i).c_int);
    Pch(i).gf.ma_pph = Frmt.GarantiaFisica(Pch(i).ma_pph, Pch(i).desc, Pch(i).c_int);
    Pch(i).gf.mh_pph = Frmt.GarantiaFisica(Pch(i).mh_pph, Pch(i).desc, Pch(i).c_int);
end

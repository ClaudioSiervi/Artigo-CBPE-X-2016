clc; clear all;
close all;

u = 6;      % n�mero de usinas

Pch(u) = UsinaDistribuida;
%Pch(1:u).gf = GarantiaFisica;

Dados = BasesDados;
Frmt = Ferramentas;

for i = 1:u
    
    % leitura e pr� processamento
    Pch(i).nome = strcat('pch', int2str(i));
   
    Pch(i).horas = Frmt.EstimaHoras(Frmt.LimpaSerie(Dados.horas(:, i)));
    Pch(i).meses = size(Pch(i).horas, 1);
    Pch(i).anos = floor(Pch(i).meses./12);
    Pch(i).horas_anos = Pch(i).HorasAnos(Pch(i));                           % Total de horas em cada ano
    
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
    Pch(i).p_gerMWmAno = Frmt.calc_ma_p_gerMWmAno(Pch(i));                              % Energia m�dia anual (ponderada pelas horas do m�s)
    Pch(i).dvp_p_gerMWmAno = Frmt.calc_dvp_p_gerMWmAno(Pch(i));                         % Desvio padr�o da energia m�dia anual
    
    % estat�sticas
    Pch(i).corr_p_q = corrcoef(Pch(i).p_gerMW, Pch(i).q);           % correla��o entre a pot�ncia gerada(MW) e a vaz�o(m�/s)
    
    Pch(i).ma_q_ano = Pch(i).calc_ma_qAno(Pch(i));                  % Vaz�o m�dia anual
    Pch(i).frq_q_ano = Frmt.FreqAcumulada(Pch(i).q, ...             % Perman�ncia que ficou acima da vaz�o m�dia
                            mean(Pch(i).ma_q_ano), Pch(i).meses);
    Pch(i).dvp_q_ano = Pch(i).calc_dvp_qAno(Pch(i));                % Desvio padr�o da vaz�o m�dia anual
    
    % C�lculo das pot�ncias m�dias
    Pch(i).ma_prt = Frmt.MediaAritmetica(Pch(i).p_gerMW);           % M�dia Arit. mensal (Pger em MW)    
    
    Pch(i).mh_prt = Frmt.MediaHarmonica(Pch(i).p_gerMW);            % M�dia Harm. mensal (Pger em MW)
    
    Pch(i).ma_pph = Frmt.MediaAritPonderada(Pch(i).p_gerMWmAno, Pch(i).horas_anos);   % M�dia Arit. ponderada pelas horas anuais
    
    Pch(i).mh_pph = Frmt.MediaHarmPonderada(Pch(i).p_gerMWmAno,Pch(i).horas_anos);    % M�dia Harm. ponderada pelas horas anuais
    
    % C�lculo das garantias f�sicas
    Pch(i).gf.ma_prt = Frmt.GarantiaFisica(Pch(i).ma_prt, Pch(i).desc, Pch(i).c_int);
    Pch(i).gf.frq_ma_prt = Frmt.FreqAcumulada(Pch(i).p_gerMW,Pch(i).gf.ma_prt, Pch(i).meses);       % Perman�ncia que ficou acima da garantia f�sica
    Pch(i).gf.dvp_ma_prt = Frmt.DvpResiduosQuad(Pch(i).p_gerMW, Pch(i).gf.ma_prt);      
    Pch(i).gf.dvp_abs_ma_prt = Frmt.DvpResiduosAbs(Pch(i).p_gerMW, Pch(i).gf.ma_prt);
    
    Pch(i).gf.mh_prt = Frmt.GarantiaFisica(Pch(i).mh_prt, Pch(i).desc, Pch(i).c_int);
    Pch(i).gf.frq_mh_prt = Frmt.FreqAcumulada(Pch(i).p_gerMW, Pch(i).gf.mh_prt, Pch(i).meses);      % Perman�ncia que ficou acima da garantia f�sica
    Pch(i).gf.dvp_mh_prt = Frmt.DvpResiduosQuad(Pch(i).p_gerMW, Pch(i).gf.mh_prt);
    Pch(i).gf.dvp_abs_mh_prt = Frmt.DvpResiduosAbs(Pch(i).p_gerMW, Pch(i).gf.mh_prt);
    
    Pch(i).gf.ma_pph = Frmt.GarantiaFisica(Pch(i).ma_pph, Pch(i).desc, Pch(i).c_int);
    Pch(i).gf.frq_ma_pph = Frmt.FreqAcumulada(Pch(i).p_gerMWmAno, Pch(i).gf.ma_pph, Pch(i).anos);   % Perman�ncia que ficou acima da garantia f�sica
    Pch(i).gf.dvp_ma_pph = Frmt.DvpResiduosQuad(Pch(i).p_gerMWmAno, Pch(i).gf.ma_pph);
    Pch(i).gf.dvp_abs_ma_pph = Frmt.DvpResiduosAbs(Pch(i).p_gerMWmAno, Pch(i).gf.ma_pph);
    
    Pch(i).gf.mh_pph = Frmt.GarantiaFisica(Pch(i).mh_pph, Pch(i).desc, Pch(i).c_int);
    Pch(i).gf.frq_mh_pph = Frmt.FreqAcumulada(Pch(i).p_gerMWmAno, Pch(i).gf.mh_pph, Pch(i).anos);   % Perman�ncia que ficou acima da garantia f�sica
    Pch(i).gf.dvp_mh_pph = Frmt.DvpResiduosQuad(Pch(i).p_gerMWmAno, Pch(i).gf.mh_pph);
    Pch(i).gf.dvp_abs_mh_pph = Frmt.DvpResiduosAbs(Pch(i).p_gerMWmAno, Pch(i).gf.mh_pph);
end

plota_vazoes(Pch)

plota_potencias(Pch)

plota_permanencias(Pch)

Dados.ImprimeGarantiaFisica(Pch);

Dados.ImprimeAnalise(Pch);


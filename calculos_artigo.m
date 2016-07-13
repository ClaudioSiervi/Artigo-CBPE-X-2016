clc; clear all;

u = 6;      % número de usinas

Dados = ImportaDados;
Pch(u) = UsinaDistribuida;
Ferramenta = Ferramentas;

for i = 1:u
    
    % leitura e pré processamento
    Pch(i).nome = strcat('pch', int2str(i));
    Pch(i).horas = Ferramenta.EstimaHoras(Ferramenta.LimpaSerie(Dados.horas(:, i)));
    Pch(i).meses = size(Pch(i).horas, 1);
    Pch(i).anos = floor(Pch(i).meses./12);                    
    Pch(i).q = Ferramenta.LimpaSerie(Dados.vazoes(:, i));
    Pch(i).p_instMW = Dados.premissas(1, i);
    Pch(i).rend = Dados.premissas(2, i);
    Pch(i).hl = Dados.premissas(3, i);
    Pch(i).qs = Dados.premissas(4, i);
    Pch(i).desc = Dados.premissas(11, i);
    Pch(i).c_int = Dados.premissas(13, i);    
    
    % cálculos
    Pch(i).p_instW = Pch(i).p_instMW * 1000000; %Conversão MW -> W
    Pch(i).p_estW = Pch(i).rho*Pch(i).g*Pch(i).hl*Pch(i).rend*(Pch(i).q - Pch(i).qs);   % (W)
    Pch(i).p_gerW = min(Pch(i).p_estW, Pch(i).p_instW).*Pch(i).desc;                    % (W)
    Pch(i).p_gerMW = Pch(i).p_gerW./1000000; % W -> MW
    Pch(i).p_gerMWh = Pch(i).p_gerMW .*Pch(i).horas; 
    
    % estatísticas
    Pch(i).ma_p_gerMWmAno = Pch(i).calc_ma_p_gerMWmAno(Pch(i));
    Pch(i).dvp_p_gerMWmAno = Pch(i).calc_dvp_p_gerMWmAno(Pch(i));
    
    
end
dd
clc; clear all;

u = 6;      % n�mero de usinas

Dados = ImportaDados;
Pch(u) = UsinaDistribuida;
Ferramenta = Ferramentas;

for i = 1:u
    Pch(i).nome = strcat('pch', int2str(i));
    Pch(i).horas = Ferramenta.EstimaHoras(Ferramenta.LimpaSerie(Dados.horas(:, i)));
    Pch(i).q = Ferramenta.LimpaSerie(Dados.vazoes(:, i));
    Pch(i).p_inst = Dados.premissas(1, i);
    Pch(i).rend = Dados.premissas(2, i);
    Pch(i).hl = Dados.premissas(3, i);
    Pch(i).qs = Dados.premissas(4, i);
    Pch(i).desc = Dados.premissas(11, i);
    Pch(i).c_int = Dados.premissas(13, i);    
end
dd
clc; clear all;

u = 6;      % número de usinas

Dados = ImportaDados;
Pch(u) = UsinaD;

for i = 1:u
    Pch(i).nome = strcat('pch', int2str(i));
    Pch(i).q = Dados.LimpaSerie(Dados.vazoes(:, i));
    
end
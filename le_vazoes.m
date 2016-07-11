function [q] = le_vazoes()

% Lê vazões
arquivo = 'Dados_Artigo.xlsx';
aba = 'vazões';
caminho = pwd;
rota = strcat(caminho,'\',arquivo);
intervalo = 'C7:H1000';
dados = xlsread(rota, aba, intervalo);

q = struct('pch1',[],'pch2',[],'pch3',[], ...
    'pch4',[], 'pch5',[], 'pch6',[]); % vazões
for i = 1:6
    
    fim = find(isnan(dados(:,i))==1, 1, 'first');   % encontra o 1º NaN
    fim = fim - 1;                                  % último dado válido
    if isempty(fim)                                 % se não tem NaN define o próprio vetor
        fim = size(dados(:,i),1) ;
    end
    
    nome_campo = strcat('pch', int2str(i));
    
    vazao = dados(1:fim, i);
    q.(nome_campo) = vazao;
end

d=le_datas;
%plota_vazoes(q)

end


function [d] = le_datas()

arquivo = 'Dados_Artigo.xlsx';
aba = 'vazões';
caminho = pwd;
rota = strcat(caminho,'\',arquivo);
intervalo = 'J7:O1000';
dados = readtable('Dados_Artigo.xlsx');
%dados = xlsread(rota, aba, intervalo);

d = struct('pch1',[],'pch2',[],'pch3',[], ...
    'pch4',[], 'pch5',[], 'pch6',[]); % datas
for i = 8:13
    
    fim = find(isnan(dados(:,i))==1, 1, 'first');   % encontra o 1º NaN
    fim = fim - 1;                                  % último dado válido
    if isempty(fim)                                 % se não tem NaN define o próprio vetor
        fim = size(dados(:,i),1) ;
    end
    
    nome_campo = strcat('pch', int2str(i));
    
    data = dados(1:fim, i);
    d.(nome_campo) = data;
end

end
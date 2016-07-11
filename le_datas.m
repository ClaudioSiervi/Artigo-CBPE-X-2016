function [d] = le_datas()

    arquivo = 'Dados_Artigo.xlsx';
    aba = 'vazões';
    caminho = pwd;
    rota = strcat(caminho,'\',arquivo);
    intervalo = 'J5:O1000';
    %dados = readtable('Dados_Artigo.xlsx');
    dados = xlsread(rota, aba, intervalo);

    d = struct('pch1',[],'pch2',[],'pch3',[], ...
        'pch4',[], 'pch5',[], 'pch6',[]); % datas
    for i = 1:6

        fim = find(isnan(dados(:,i))==1, 1, 'first');   % encontra o 1º NaN
        fim = fim - 1;                                  % último dado válido
        if isempty(fim)                                 % se não tem NaN define o próprio vetor
            fim = size(dados(:,i),1) ;
        end
        data = dados(1:fim, i);                         % datas em formato numérico

        [l]=size(data,1);
        dias = zeros(l,1);
        for j = 1:(l-1) % na planilha há 1 mês a mais
            dias(j,1) = daysdif(data(j), data(j+1));    % qtd de dias em 1 mês
        end

        nome_campo = strcat('pch', int2str(i));
        d.(nome_campo) = dias(1:(l-1),1);               % retira a última linha
    end

end
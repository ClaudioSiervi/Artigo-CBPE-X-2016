function [d] = le_datas()

    arquivo = 'Dados_Artigo.xlsx';
    aba = 'vaz�es';
    caminho = pwd;
    rota = strcat(caminho,'\',arquivo);
    intervalo = 'J5:O1000';
    %dados = readtable('Dados_Artigo.xlsx');
    dados = xlsread(rota, aba, intervalo);

    d = struct('pch1',[],'pch2',[],'pch3',[], ...
        'pch4',[], 'pch5',[], 'pch6',[]); % datas
    for i = 1:6

        fim = find(isnan(dados(:,i))==1, 1, 'first');   % encontra o 1� NaN
        fim = fim - 1;                                  % �ltimo dado v�lido
        if isempty(fim)                                 % se n�o tem NaN define o pr�prio vetor
            fim = size(dados(:,i),1) ;
        end
        data = dados(1:fim, i);                         % datas em formato num�rico

        [l]=size(data,1);
        dias = zeros(l,1);
        for j = 1:(l-1) % na planilha h� 1 m�s a mais
            dias(j,1) = daysdif(data(j), data(j+1));    % qtd de dias em 1 m�s
        end

        nome_campo = strcat('pch', int2str(i));
        d.(nome_campo) = dias(1:(l-1),1);               % retira a �ltima linha
    end

end
function [q] = le_vazoes()

    % L� vaz�es
    arquivo = 'Dados_Artigo.xlsx';
    aba = 'vaz�es';
    caminho = pwd;
    rota = strcat(caminho,'\',arquivo);
    intervalo = 'C5:H1000';
    dados = xlsread(rota, aba, intervalo);

    q = struct('pch1',[],'pch2',[],'pch3',[], ...
        'pch4',[], 'pch5',[], 'pch6',[]); % vaz�es
    for i = 1:6

        fim = find(isnan(dados(:,i))==1, 1, 'first');   % encontra o 1� NaN
        fim = fim - 1;                                  % �ltimo dado v�lido
        if isempty(fim)                                 % se n�o tem NaN define o pr�prio vetor
            fim = size(dados(:,i),1) ;
        end

        nome_campo = strcat('pch', int2str(i));

        vazao = dados(1:fim, i);
        q.(nome_campo) = vazao;
    end

    %d = le_datas;
    plota_vazoes(q)

end



classdef ImportaDados
    
    properties(Constant =true)
        arquivo = 'Dados_Artigo.xlsx';
        aba1 = 'vaz�es';
	    intervalo1 = 'C5:H1000';
        aba2 = 'horas'
        intervalo2 = 'C5:H1000';
        aba3 = 'premissas';
        intervalo3 = 'D4:I16';
    end
    
    properties
        caminho = pwd;      % caminho da pasta ra�z
        vazoes;             % s�ries hist�ricas de vaz�o
        horas;              % total de horas em cada m�s da s�rie hist�rica
        premissas;          % pot�ncia instalada, teif, ip, perdas el�tricas, ...
    end
    
    methods
        % Desvio padr�o das pot�ncias anuais
        function obj = ImportaDados()
            dados = obj;
            rota = strcat(obj.caminho,'\',ImportaDados.arquivo);
            dados.vazoes = xlsread(rota, ImportaDados.aba1, ImportaDados.intervalo1');  
           % obj.horas = xlsread(rota, ImportaDados.aba2, ImportaDados.intervalo2');  
           % obj.premissas = xlsread(rota, ImportaDados.aba3, ImportaDados.intervalo3');  
        
            AjustaSerie(dados, obj);
        end
    
    
        function AjustaSerie(dados, obj)

            for i = 1:6
                fim = find(isnan(dados.vazoes(:,i))==1, 1, 'first');  % encontra o 1� NaN
                fim = fim - 1;                                      % �ltimo dado v�lido
                if isempty(fim)                                     % se n�o tem NaN define o pr�prio vetor
                    fim = size(dados.vazoes(:,i),1) ;
                end
                vazao = dados.vazoes(1:fim,i);
                obj.vazoes(:,i) = vazao;
                
                %nome_campo = strcat('pch', int2str(i));
                %vazao = dados(1:fim, i);
                %q.(nome_campo) = vazao;
            end
        end
    end
end
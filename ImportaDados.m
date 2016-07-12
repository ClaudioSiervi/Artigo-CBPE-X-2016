classdef ImportaDados
    
    properties(Constant =true)
        arquivo = 'Dados_Artigo.xlsx';
        aba1 = 'vazões';
	    intervalo1 = 'C5:H1000';
        aba2 = 'horas'
        intervalo2 = 'C5:H1000';
        aba3 = 'premissas';
        intervalo3 = 'D4:I16';
    end
    
    properties
        caminho = pwd;      % caminho da pasta raíz
        vazoes;             % séries históricas de vazão
        horas;              % total de horas em cada mês da série histórica
        premissas;          % potência instalada, teif, ip, perdas elétricas, ...
    end
    
    methods
        % Desvio padrão das potências anuais
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
                fim = find(isnan(dados.vazoes(:,i))==1, 1, 'first');  % encontra o 1º NaN
                fim = fim - 1;                                      % último dado válido
                if isempty(fim)                                     % se não tem NaN define o próprio vetor
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
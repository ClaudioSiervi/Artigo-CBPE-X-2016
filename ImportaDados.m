classdef  ImportaDados
    
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
        % ----- Lê do excel as séries de vazão, horas e premissas 
        function obj = ImportaDados()
            % SAÍDAS
            %   obj -> objeto contendo todas as séries lidas do excel
        
            rota = strcat(obj.caminho,'\',ImportaDados.arquivo);
            obj.vazoes = xlsread(rota, ImportaDados.aba1, ImportaDados.intervalo1');  
            obj.horas = xlsread(rota, ImportaDados.aba2, ImportaDados.intervalo2');  
            obj.premissas = xlsread(rota, ImportaDados.aba3, ImportaDados.intervalo3');   
        end
        
    end
end
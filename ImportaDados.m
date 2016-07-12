classdef  ImportaDados
    
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
        % ----- L� do excel as s�ries de vaz�o, horas e premissas 
        function obj = ImportaDados()
            % SA�DAS
            %   obj -> objeto contendo todas as s�ries lidas do excel
        
            rota = strcat(obj.caminho,'\',ImportaDados.arquivo);
            obj.vazoes = xlsread(rota, ImportaDados.aba1, ImportaDados.intervalo1');  
            obj.horas = xlsread(rota, ImportaDados.aba2, ImportaDados.intervalo2');  
            obj.premissas = xlsread(rota, ImportaDados.aba3, ImportaDados.intervalo3');   
        end
        
    end
end
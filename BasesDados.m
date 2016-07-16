classdef  BasesDados
    
    properties(Constant =true)
        arquivo_entrada = 'Dados_Artigo.xlsx';        
        aba1 = 'vaz�es';
	    intervalo1 = 'C5:H1000';
        aba2 = 'horas'
        intervalo2 = 'C5:H1000';
        aba3 = 'premissas';
        intervalo3 = 'D4:I16';
        
        arquivo_saida = 'Resultados_Artigo.xlsx';
        aba_geral = 'Geral';
        aba_gf = 'GarantiaF�sica'
    end
    
    properties
        caminho = pwd;      % caminho da pasta ra�z
        vazoes;             % s�ries hist�ricas de vaz�o
        horas;              % total de horas em cada m�s da s�rie hist�rica
        premissas;          % pot�ncia instalada, teif, ip, perdas el�tricas, ...
    end
    
    methods
        
        % ----- L� do excel as s�ries de vaz�o, horas e premissas 
        function obj = BasesDados()
            % SA�DAS
            %   obj -> objeto contendo todas as s�ries lidas do excel
        
            rota = strcat(obj.caminho,'\',BasesDados.arquivo_entrada);
            obj.vazoes = xlsread(rota, BasesDados.aba1, BasesDados.intervalo1');  
            obj.horas = xlsread(rota, BasesDados.aba2, BasesDados.intervalo2');  
            obj.premissas = xlsread(rota, BasesDados.aba3, BasesDados.intervalo3');   
        end
    end
    
    %--------------
    methods(Static)
        
        function ImprimeGarantiaFisica(gf)
            
            ma_prt = [gf.ma_prt; gf.frq_ma_prt; gf.dvp_ma_prt; gf.dvp_abs_ma_prt]; % cell
            mh_prt = [gf.mh_prt; gf.frq_mh_prt; gf.dvp_mh_prt; gf.dvp_abs_mh_prt]; % or array?
            ma_pph = [gf.ma_pph; gf.frq_ma_pph; gf.dvp_ma_pph; gf.dvp_abs_ma_pph];
            mh_pph = [gf.mh_pph; gf.frq_mh_pph; gf.dvp_mh_pph; gf.dvp_abs_mh_pph];
            
            garantia_fisica = [ma_prt mh_prt ma_pph mh_pph];
            
            aba = 'Garantia F�sica';
            posicao = 'C4';
            % numerico, celula ou vetor
            xlswrite(BasesDados.arquivo_saida, garantia_fisica, aba, posicao);
            %xlswrite(ImportaDados.arquivo_saida, pch(1).gf,obj.aba_geral);
            
            
        end
    end
end
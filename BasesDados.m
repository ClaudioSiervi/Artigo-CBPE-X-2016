classdef  BasesDados
    
    properties(Constant =true)
        arquivo_entrada = 'Dados_Artigo.xlsx';        
        aba1 = 'vazões';
	    intervalo1 = 'C5:H1000';
        aba2 = 'horas'
        intervalo2 = 'C5:H1000';
        aba3 = 'premissas';
        intervalo3 = 'D4:I16';
        
        arquivo_saida = 'Resultados_Artigo.xlsx';
        aba_geral = 'Geral';
        aba_gf = 'GarantiaFísica'
    end
    
    properties
        caminho = pwd;      % caminho da pasta raíz
        vazoes;             % séries históricas de vazão
        horas;              % total de horas em cada mês da série histórica
        premissas;          % potência instalada, teif, ip, perdas elétricas, ...
    end
    
    methods
        
        % ----- Lê do excel as séries de vazão, horas e premissas 
        function obj = BasesDados()
            % SAÍDAS
            %   obj -> objeto contendo todas as séries lidas do excel
        
            rota = strcat(obj.caminho,'\',BasesDados.arquivo_entrada);
            obj.vazoes = xlsread(rota, BasesDados.aba1, BasesDados.intervalo1');  
            obj.horas = xlsread(rota, BasesDados.aba2, BasesDados.intervalo2');  
            obj.premissas = xlsread(rota, BasesDados.aba3, BasesDados.intervalo3');   
        end
    end
    
    %--------------
    methods(Static)
        
        
        function ImprimeGarantiaFisica(Pch)
           
            u = size(Pch,2);
            
            for i = 1:u
                gf = Pch(i).gf;
                ma_prt = [gf.ma_prt; gf.frq_ma_prt; gf.dvp_ma_prt; gf.dvp_abs_ma_prt]; % cell
                mh_prt = [gf.mh_prt; gf.frq_mh_prt; gf.dvp_mh_prt; gf.dvp_abs_mh_prt]; % or array?
                ma_pph = [gf.ma_pph; gf.frq_ma_pph; gf.dvp_ma_pph; gf.dvp_abs_ma_pph];
                mh_pph = [gf.mh_pph; gf.frq_mh_pph; gf.dvp_mh_pph; gf.dvp_abs_mh_pph];

                garantia_fisica = [ma_prt mh_prt ma_pph mh_pph];

                indice = (i-1)*8;
                posicao = strcat('C', int2str(indice + 2));

                aba = 'Garantia Física';
                % numerico, celula ou vetor
                xlswrite(BasesDados.arquivo_saida, {strcat('PCH',int2str(i))}, aba, posicao);
                posicao = strcat('C', int2str(indice + 3));
                xlswrite(BasesDados.arquivo_saida, { 'ma_prt' 'mh_prt' 'ma_pph' 'mh_pph'}, aba, posicao);
                posicao = strcat('C', int2str(indice + 4));
                xlswrite(BasesDados.arquivo_saida, garantia_fisica, aba, posicao);
                posicao = strcat('B', int2str(indice + 4));
                top_linha(1,1)={'médias'};
                top_linha(2,1)={'freq. acumulada'};
                top_linha(3,1)={'dvp. quadrado'};
                top_linha(4,1)={'dvp. absoluto'};

                xlswrite(BasesDados.arquivo_saida,top_linha, aba, posicao);
            end
        end
        
        
        %------------------------------
        function ImprimeCorrelacao(corr)
            xlswrite(BasesDados.arquivo_saida, {strcat('PCH',int2str(i))}, aba, posicao);
            posicao = strcat('C', int2str(indice + 3));
        end
    end
end
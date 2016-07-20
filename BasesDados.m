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
            
            aba = 'Garantia Física';
            
            top_linha(1,1)={'médias'};
            top_linha(2,1)={'freq. acumulada'};
            top_linha(3,1)={'dvp. quadrado'};
            top_linha(4,1)={'dvp. absoluto'};
            
            for i = 1:u
                
                gf = Pch(i).gf;
                ma_prt = [gf.ma_prt; gf.frq_ma_prt; gf.dvp_ma_prt; gf.dvp_abs_ma_prt]; % cell
                mh_prt = [gf.mh_prt; gf.frq_mh_prt; gf.dvp_mh_prt; gf.dvp_abs_mh_prt]; % or array?
                ma_pph = [gf.ma_pph; gf.frq_ma_pph; gf.dvp_ma_pph; gf.dvp_abs_ma_pph];
                mh_pph = [gf.mh_pph; gf.frq_mh_pph; gf.dvp_mh_pph; gf.dvp_abs_mh_pph];

                garantia_fisica = [ma_prt mh_prt ma_pph mh_pph];

                indice = (i-1)*8;
                posicao = strcat('C', int2str(indice + 2));

                % numerico, celula ou vetor
                xlswrite(BasesDados.arquivo_saida, {strcat('PCH',int2str(i))}, aba, posicao);
                posicao = strcat('C', int2str(indice + 3));
                xlswrite(BasesDados.arquivo_saida, { 'ma_prt' 'mh_prt' 'ma_pph' 'mh_pph'}, aba, posicao);
                posicao = strcat('C', int2str(indice + 4));
                xlswrite(BasesDados.arquivo_saida, garantia_fisica, aba, posicao);
                posicao = strcat('B', int2str(indice + 4));

                xlswrite(BasesDados.arquivo_saida,top_linha, aba, posicao);
            end
        end
        
        
        %------------------------------
        function ImprimeAnalise(Pch)
           
            u = size(Pch,2);
            correlacao_pq = zeros(u, 1);
            media_q = zeros(u, 1);
            dvp_q = zeros(u, 1);
            ma_prt = zeros(u, 1);
            mh_prt = zeros(u, 1);
            ma_pph = zeros(u, 1);
            mh_pph = zeros(u, 1);
            
            frq_ma_prt = zeros(u, 1);
            frq_mh_prt = zeros(u, 1);
            frq_ma_pph = zeros(u, 1);
            frq_mh_pph = zeros(u, 1);
            
            for i = 1:u
                gf = Pch(i).gf;
                
                ma_prt(i,1) = gf.ma_prt;    
                mh_prt(i,1) = gf.mh_prt;    
                ma_pph(i,1) = gf.ma_pph;    
                mh_pph(i,1) = gf.mh_pph;    %[gf.mh_pph; gf.frq_mh_pph; gf.dvp_mh_pph; gf.dvp_abs_mh_pph];
                
                frq_ma_prt(i,1) = gf.frq_ma_prt;    
                frq_mh_prt(i,1) = gf.frq_mh_prt;    
                frq_ma_pph(i,1) = gf.frq_ma_pph;    
                frq_mh_pph(i,1) = gf.frq_mh_pph;    
                
                correlacao_pq(i,1) = Pch(i).corr_p_q(1,2);
                media_q(i,1) = mean(Pch(i).q);
                dvp_q(i,1) = std(Pch(i).q);
            end

            aba = 'Análises';
            posicao = 'C3';
            
            garantia_fisica = [ma_prt, mh_prt, ma_pph, mh_pph];
            frequencia = [frq_ma_prt, frq_mh_prt, frq_ma_pph, frq_mh_pph];
            imprimir = [garantia_fisica, frequencia, correlacao_pq, media_q, dvp_q];
            xlswrite(BasesDados.arquivo_saida, imprimir, aba, 'C3');
            
            top_col = {'GF_ma_prt(MWm)', 'GF_mh_prt(MWm)', 'GF_ma_pph(MWm)', 'GF_mh_pph(MWm)', ...
                       'frq_ma_prt(%)', 'frq_mh_prt(%)', 'frq_ma_pph(%)', 'frq_mh_pph(%)', ...
                       'Corr(p,q)', 'Média(q)(m³/s)', 'Dvp(q) (m³/s)'};
            xlswrite(BasesDados.arquivo_saida, top_col, aba, 'C2');
            
            top_lin(1,1)={'PCH1'}; top_lin(2,1)={'PCH2'}; top_lin(3,1)={'PCH3'};
            top_lin(4,1)={'PCH4'}; top_lin(5,1)={'PCH5'}; top_lin(6,1)={'PCH6'};
            xlswrite(BasesDados.arquivo_saida, top_lin, aba, 'B3');
        end
    end
end
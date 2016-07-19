% Gera gráfico da frenquencia acumulada da potência gerada em MW-mês
function plota_permanencias(Pch)
    
    % Determina as frequências 
    function [f]= frequencia_acumulada(tam)
        x = ones(tam,1);    x(:,1) = x(:,1)./tam;  f = zeros(tam,1);
        f(1,1) = x(1,1);
        for i=2:tam
            f(i,1) = f(i-1,1)+ x(i,1);
        end
    end


    figure
    
    subplot(2,3,1);
    tam = size(Pch(1).p_gerMW,1);
    freq = frequencia_acumulada(tam);
    gf_ma_prt = Pch(1).gf.ma_prt*ones(tam,1);       % gf ma prt
    %gf_mh_prt = Pch(1).gf.mh_prt*ones(tam,1);
    gf_ma_pph = Pch(1).gf.ma_pph*ones(tam,1);       % gf ma pot pond hora
    gf_mh_pph = Pch(1).gf.mh_pph*ones(tam,1);       % gf mh pot pond hora
    pot = sort(Pch(1).p_gerMW,'descend');
    y = [pot,gf_ma_prt, gf_ma_pph, gf_mh_pph];
    plot(freq, y);
    axis([0 1 0 30]);
    xlabel('Permanência (%)');
    ylabel({'Potência Gerada(MW) - Usina A'});
    legend('Pger','GF_{MA-PRT}', 'GF_{MAP}', 'GF_{MHP}', 'Location', 'northeast');
    legend('boxoff');

   
    
    subplot(2,3,2);
    tam = size(Pch(2).p_gerMW,1);
    freq = frequencia_acumulada(tam);
    gf_ma_prt = Pch(2).gf.ma_prt*ones(tam,1);       % gf ma prt
    %gf_mh_prt = Pch(2).gf.mh_prt*ones(tam,1);
    gf_ma_pph = Pch(2).gf.ma_pph*ones(tam,1);       % gf ma pot pond hora
    gf_mh_pph = Pch(2).gf.mh_pph*ones(tam,1);       % gf mh pot pond hora
    pot = sort(Pch(2).p_gerMW,'descend');
    y = [pot,gf_ma_prt, gf_ma_pph, gf_mh_pph];
    plot(freq, y);
    axis([0 1 0 30]);
    xlabel('Permanência (%)');
    ylabel({'Potência Gerada(MW) - Usina B '});
    legend('Pger','GF_{MA-PRT}', 'GF_{MAP}', 'GF_{MHP}', 'Location', 'southwest');
    legend('boxoff');
    

    
    subplot(2,3,3);
    tam = size(Pch(3).p_gerMW,1);
    freq = frequencia_acumulada(tam);
    gf_ma_prt = Pch(3).gf.ma_prt*ones(tam,1);       % gf ma prt
    %gf_mh_prt = Pch(3).gf.mh_prt*ones(tam,1);
    gf_ma_pph = Pch(3).gf.ma_pph*ones(tam,1);       % gf ma pot pond hora
    gf_mh_pph = Pch(3).gf.mh_pph*ones(tam,1);       % gf mh pot pond hora
    pot = sort(Pch(3).p_gerMW,'descend');
    y = [pot,gf_ma_prt, gf_ma_pph, gf_mh_pph];
    plot(freq, y);
    axis([0 1 0 30]);
    xlabel('Permanência (%)');
    ylabel({'Potência Gerada(MW) - Usina C'});
    legend('Pger','GF_{MA-PRT}', 'GF_{MAP}', 'GF_{MHP}', 'Location', 'southwest');
    legend('boxoff');
    
    
    
    subplot(2,3,4);
    tam = size(Pch(4).p_gerMW,1);
    freq = frequencia_acumulada(tam);
    gf_ma_prt = Pch(4).gf.ma_prt*ones(tam,1);       % gf ma prt
    %gf_mh_prt = Pch(4).gf.mh_prt*ones(tam,1);
    gf_ma_pph = Pch(4).gf.ma_pph*ones(tam,1);       % gf ma pot pond hora
    gf_mh_pph = Pch(4).gf.mh_pph*ones(tam,1);       % gf mh pot pond hora
    pot = sort(Pch(4).p_gerMW,'descend');
    y = [pot,gf_ma_prt, gf_ma_pph, gf_mh_pph];
    plot(freq, y);
    axis([0 1 0 30]);
    xlabel('Permanência (%)');
    ylabel({'Potência Gerada(MW) - Usina D'});
    legend('Pger','GF_{MA-PRT}', 'GF_{MAP}', 'GF_{MHP}', 'Location', 'southwest');
    legend('boxoff');
    


    subplot(2,3,5);
    tam = size(Pch(5).p_gerMW,1);
    freq = frequencia_acumulada(tam);
    gf_ma_prt = Pch(5).gf.ma_prt*ones(tam,1);       % gf ma prt
    %gf_mh_prt = Pch(5).gf.mh_prt*ones(tam,1);
    gf_ma_pph = Pch(5).gf.ma_pph*ones(tam,1);       % gf ma pot pond hora
    gf_mh_pph = Pch(5).gf.mh_pph*ones(tam,1);       % gf mh pot pond hora
    pot = sort(Pch(5).p_gerMW,'descend');
    y = [pot,gf_ma_prt, gf_ma_pph, gf_mh_pph];
    plot(freq, y);
    axis([0 1 0 30]);
    xlabel('Permanência (%)');
    ylabel({'Potência Gerada(MW) - Usina E'});
    legend('Pger','GF_{MA-PRT}', 'GF_{MAP}', 'GF_{MHP}', 'Location', 'southwest');
    legend('boxoff');
    
    

    subplot(2,3,6);
    tam = size(Pch(6).p_gerMW,1);
    freq = frequencia_acumulada(tam);
    gf_ma_prt = Pch(6).gf.ma_prt*ones(tam,1);       % gf ma prt
    %gf_mh_prt = Pch(6).gf.mh_prt*ones(tam,1);
    gf_ma_pph = Pch(6).gf.ma_pph*ones(tam,1);       % gf ma pot pond hora
    gf_mh_pph = Pch(6).gf.mh_pph*ones(tam,1);       % gf mh pot pond hora
    pot = sort(Pch(6).p_gerMW,'descend');
    y = [pot,gf_ma_prt, gf_ma_pph, gf_mh_pph];
    plot(freq, y);
    axis([0 1 0 30]);
    xlabel('Permanência (%)');
    ylabel({'Potência Gerada(MW) - Usina F'});
    legend('Pger','GF_{MA-PRT}', 'GF_{MAP}', 'GF_{MHP}', 'Location', 'northeast');
    legend('boxoff');

end
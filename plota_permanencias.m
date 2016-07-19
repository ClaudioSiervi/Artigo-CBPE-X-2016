% Plota as potencias geradas em MW-mês
function plota_permanencias(Pch)

    figure
    
    subplot(2,3,1);
    tam = size(Pch(1).p_gerMW,1);
    plot(1:tam, Pch(1).p_gerMW); 
    axis([0 tam 0 40]);
    xlabel('Meses');
    ylabel({'Potência Gerada - Usina A','(MW)'});
    legend('Potência Gerada na Usina A', 'Location', 'northeast');
    legend('boxoff');

   
    
    subplot(2,3,2);
    tam = size(Pch(2).p_gerMW,1);
    plot(1:tam, Pch(2).p_gerMW);
    axis([0 tam 0 40]);
    xlabel('Meses');
    ylabel({'Potência Gerada - Usina B','(MW)'});
    legend('Potência Gerada na Usina B', 'Location', 'northeast');
    legend('boxoff');

    subplot(2,3,3);
    tam = size(Pch(3).p_gerMW,1);
    plot(1:tam, Pch(3).p_gerMW);
    axis([0 tam 0 40]);
    xlabel('Meses');
    ylabel({'Potência Gerada - Usina C','(MW)'});
    legend('Potência Gerada na Usina C', 'Location', 'northeast');
    legend('boxoff');

    subplot(2,3,4);
    tam = size(Pch(4).p_gerMW,1);
    plot(1:tam, Pch(4).p_gerMW);
    axis([0 tam 0 40]);
    xlabel('Meses');
    ylabel({'Potência Gerada - Usina D','(MW)'});
    legend('Potência Gerada na Usina D', 'Location', 'northeast');
    legend('boxoff');

    subplot(2,3,5);
    tam = size(Pch(5).p_gerMW,1);
    plot(1:tam, Pch(5).p_gerMW);
    axis([0 tam 0 40]);
    xlabel('Meses');
    ylabel({'Potência Gerada - Usina E','(MW)'});
    legend('Potência Gerada na Usina E', 'Location', 'northeast');
    legend('boxoff');

    subplot(2,3,6);
    tam = size(Pch(6).p_gerMW,1);
    plot(1:tam, Pch(6).p_gerMW);
    axis([0 tam 0 40]);
    xlabel('Meses');
    ylabel({'Potência Gerada - Usina F','(MW)'});
    legend('Potência Gerada na Usina F', 'Location', 'northeast');
    legend('boxoff');

end
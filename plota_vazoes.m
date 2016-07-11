
% Plota vazões
function plota_vazoes(q)

    figure
    
    
    subplot(2,3,1);
    tam = size(q.pch1,1);
    plot(1:tam, q.pch1); 
    axis([0 tam 20 160]);
    xlabel('Meses');
    ylabel({'Vazão','(m³/s)'});
    legend('Vazão da Usina A', 'Location', 'northeast');
    legend('boxoff');

    subplot(2,3,2);
    tam = size(q.pch2,1);
    plot(1:tam, q.pch2);
    axis([0 tam 20 120]);
    xlabel('Meses');
    ylabel({'Vazão','(m³/s)'});
    legend('Vazão da Usina B', 'Location', 'northeast');
    legend('boxoff');

    subplot(2,3,3);
    tam = size(q.pch3,1);
    plot(1:tam, q.pch3);
    axis([0 tam 0 800]);
    xlabel('Meses');
    ylabel({'Vazão','(m³/s)'});
    legend('Vazão da Usina C', 'Location', 'northeast');
    legend('boxoff');

    subplot(2,3,4);
    tam = size(q.pch4,1);
    plot(1:tam, q.pch4);
    axis([0 tam 0 600]);
    xlabel('Meses');
    ylabel({'Vazão','(m³/s)'});
    legend('Vazão da Usina D', 'Location', 'northeast');
    legend('boxoff');

    subplot(2,3,5);
    tam = size(q.pch5,1);
    plot(1:tam, q.pch5);
    axis([0 tam 80 400]);
    xlabel('Meses');
    ylabel({'Vazão','(m³/s)'});
    legend('Vazão da Usina E', 'Location', 'northeast');
    legend('boxoff');

    subplot(2,3,6);
    tam = size(q.pch6,1);
    plot(1:tam, q.pch6);
    axis([0 tam 0 40]);
    xlabel('Meses');
    ylabel({'Vazão','(m³/s)'});
    legend('Vazão da Usina F', 'Location', 'northeast');
    legend('boxoff');

end
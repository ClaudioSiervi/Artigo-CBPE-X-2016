
% Plota vazões
function plota_vazoes(Pch)

    figure
    
    subplot(2,3,1);
    tam = size(Pch(1).q,1);
    plot(1:tam, Pch(1).q); 
    axis([0 tam 20 160]);
    xlabel('Meses');
    ylabel({'Vazão','(m³/s)'});
    legend('Vazão da Usina A', 'Location', 'northeast');
    legend('boxoff');

    subplot(2,3,2);
    tam = size(Pch(2).q,1);
    plot(1:tam, Pch(2).q);
    axis([0 tam 20 120]);
    xlabel('Meses');
    ylabel({'Vazão','(m³/s)'});
    legend('Vazão da Usina B', 'Location', 'northeast');
    legend('boxoff');

    subplot(2,3,3);
    tam = size(Pch(3).q,1);
    plot(1:tam, Pch(3).q);
    axis([0 tam 0 800]);
    xlabel('Meses');
    ylabel({'Vazão','(m³/s)'});
    legend('Vazão da Usina C', 'Location', 'northeast');
    legend('boxoff');

    subplot(2,3,4);
    tam = size(Pch(4).q,1);
    plot(1:tam, Pch(4).q);
    axis([0 tam 0 600]);
    xlabel('Meses');
    ylabel({'Vazão','(m³/s)'});
    legend('Vazão da Usina D', 'Location', 'northeast');
    legend('boxoff');

    subplot(2,3,5);
    tam = size(Pch(5).q,1);
    plot(1:tam, Pch(5).q);
    axis([0 tam 80 400]);
    xlabel('Meses');
    ylabel({'Vazão','(m³/s)'});
    legend('Vazão da Usina E', 'Location', 'northeast');
    legend('boxoff');

    subplot(2,3,6);
    tam = size(Pch(6).q,1);
    plot(1:tam, Pch(6).q);
    axis([0 tam 0 40]);
    xlabel('Meses');
    ylabel({'Vazão','(m³/s)'});
    legend('Vazão da Usina F', 'Location', 'northeast');
    legend('boxoff');

end
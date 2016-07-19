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
    plot(freq, sort(Pch(1).p_gerMW,'descend'));
    axis([0 1 0 30]);
    xlabel('Permanência (%)');
    ylabel({'Potência Gerada- Usina A','(MW)'});
    legend('Pger','GF_{MA_PRT}', 'GF_{MA}', 'GF_{MH}', 'Location', 'southwest');
    legend('boxoff');

   
    
    subplot(2,3,2);
    tam = size(Pch(2).p_gerMW,1);
    freq = frequencia_acumulada(tam);
    plot(freq, sort(Pch(2).p_gerMW,'descend'));
axis([0 1 0 30]);
xlabel('Permanência (%)');
ylabel({'Potência Gerada- Usina B','(MW)'});
legend('Pger','MA_{PRT}', 'MA', 'MH', 'Location', 'northeast');
legend('boxoff');

    subplot(2,3,3);
    tam = size(Pch(3).p_gerMW,1);
    freq = frequencia_acumulada(tam);
    plot(freq, sort(Pch(3).p_gerMW,'descend'));
axis([0 1 0 30]);
xlabel('Permanência (%)');
ylabel({'Potência Gerada- Usina C','(MW)'});% x1 = 1:1:n1;
legend('Pger','MA_{PRT}', 'MA', 'MH', 'Location', 'northeast');
legend('boxoff');

    subplot(2,3,4);
    tam = size(Pch(4).p_gerMW,1);
    freq = frequencia_acumulada(tam);
    plot(freq, sort(Pch(4).p_gerMW,'descend'));
axis([0 1 0 30]);
xlabel('Permanência (%)');
ylabel({'Potência Gerada- Usina D','(MW)'});
legend('Pger','MA_{PRT}', 'MA', 'MH', 'Location', 'southwest');
legend('boxoff');

    subplot(2,3,5);
    tam = size(Pch(5).p_gerMW,1);
    freq = frequencia_acumulada(tam);
    plot(freq, sort(Pch(5).p_gerMW,'descend'));
axis([0 1 0 30]);
xlabel('Permanência (%)');
ylabel({'Potência Gerada- Usina E','(MW)'});
legend('Pger','MA_{PRT}', 'MA', 'MH', 'Location', 'southwest');
legend('boxoff');

    subplot(2,3,6);
    tam = size(Pch(6).p_gerMW,1);
    freq = frequencia_acumulada(tam);
    plot(freq, sort(Pch(6).p_gerMW,'descend'));
axis([0 1 0 30])
xlabel('Permanência (%)')
ylabel({'Potência Gerada- Usina F','(MW)'})
legend('Pger','MA_{PRT}', 'MA', 'MH', 'Location', 'southwest');
legend('boxoff');

end
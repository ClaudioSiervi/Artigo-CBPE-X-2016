clear all
clc
num_usinas =6;
    arquivo = 'Dados_Artigo.xlsx';
    aba = 'vaz�es';
    caminho = pwd;
    rota = strcat(caminho,'\',arquivo);
    intervalo = 'C5:H1000';
    premissas = xlsread(rota, aba, intervalo);
    
    
    % ----------- Constantes
    rend = zeros(1,num_usinas);                      % rendimento (%)
    hl = zeros(1,num_usinas);                        % queda l�quida (m)
    qs = zeros(1,num_usinas);                        % vaz�o sanit�ria (m�/s)
    desc = zeros(1,num_usinas);                      % descontos = (1-TEIF)*(1-IP)*(1-PerdasEletric)
    for i = 1:num_usinas
        rend(1, i) = premissas(2,i);
        hl(1, i) = premissas(5,i);
        qs(1, i) = premissas(6,i);
        desc(1, i) = premissas(13,i);
    end
    rho = 1000;                             % massa espec�fica da �gua (Kg/m�)
    g = 9.81;                               % m�/s�
    PinstMW = ones(1, num_usinas)*30;                % pot�ncia instalada por usina (MW)
    
    
    % ----------- Vari�veis
    q = le_vazoes();                        % s�ries hist�ricas de vaz�o
    H = le_datas();
    
    L = zeros(6,1);                         % n�mero de observa��es (meses) de cada amostra
    for i=1:6
        nome = strcat('pch', int2str(i));
        L(i) = size(q.(nome), 1);
    end
    ANOS = floor(L./12);                    % N�mero de observa��es em anos
    
    Pest = struct('pch1',[],'pch2',[],'pch3',[], ...
        'pch4',[], 'pch5',[], 'pch6',[]); % datas
    for i = 1:6
        nome_campo = strcat('pch', int2str(i));
        Pest.(nome_campo) = rho*g*hl*rend*(q.(nome_campo)-qs);      % Vetor de pot�ncias estimadas (W)
        Pinst = PinstMW.*1000000;                                   % convers�o MW -> W
    end
    
    
% Matriz de pot�ncias geradas (W)
Pger = zeros(l,cenarios);
for i=1:cenarios
    Pger(:,i) = min(Pest, Pinst(:,i)).*Desc; % Pot�ncia Gerada (W)
end

%Matriz Gera��o % W -> MW
PgerMW = Pger./1000000; 

%Matriz Gera��o % MW -> MWh
PgerMWh = zeros(l,cenarios);
for i=1:cenarios
    PgerMWh(:,i) = PgerMW(:,i).*H; % Pot�ncia Gerada (MW)
end

% Valores m�dios anuais
PgerMWmAno = zeros(anos,cenarios);

dvpPgerAno = zeros(anos,cenarios);

for c=1:cenarios
    for i=1:anos
        ini = 1 + (i-1)*12;
        fim = i*12;
        % Energia M�dia Anual (ponderada pelas horas do m�s) "MWm = MWh/h" (ini:fim =12)
        PgerMWmAno(i, c) = sum(PgerMWh(ini:fim,c))./sum(H(ini:fim,1));
        % Desvio Padr�o da  Energia M�dia Anual 
        dvpPgerAno(i, c) = std(PgerMWh(ini:fim,c)./H(ini:fim,1));
    end
end

qAno = zeros(anos,1);                   
dvp_qAno = zeros(anos,1);
for i=1:anos
    
    ini = 1 + (i-1)*12;
    fim = i*12;
     
    qAno(i)= sum(q(ini:fim,1))/12;      % Vaz�o m�dia anual
    
    dvp_qAno(i) = std(q(ini:fim,1));    % Desvio padr�o da vaz�o  anual
end







 disp('   PgerMW30');
 disp(PgerMW(:,6)); 
 clc
 disp( 'PgerMWh30');
 disp(PgerMWh(:, 6)); 
 
 
 
 
 
 
%*******************  Estat�sticas  ****************


%----- M�dia aritm�tica igual a PRT 463/2009
MA_PRT = zeros(1,cenarios);
perMA_PRT = zeros(1,cenarios);
dvpMA_PRT = zeros(1,cenarios);
dvpMA_PRTabs = zeros(1,cenarios);
for c = 1:cenarios
    % M�dia com � calculada na PoRTaria do MME
    MA_PRT(1, c) = mean(PgerMW(:, c));  
    % Permanencia de anos em que PgerWm ficou acima da MA.
    perMA_PRT(1, c) = (sum(PgerMWmAno(:, c) >= MA_PRT(1, c))/anos)*100;
    % Desvio dos res�duos em rela��o a MA ao quadrado
    dvpMA_PRT(1, c) = std((PgerMWmAno(:, c) - MA_PRT(1, c)).^2);
    % Desvio dos res�duos em rela��o a MA em m�dulo
    dvpMA_PRTabs(1, c) = std(abs(PgerMWmAno(:, c) - MA_PRT(1, c)));
end


%----- M�dia Aritm�tica ponderada pelas horas dos meses
MA = zeros(1,cenarios);
perMA = zeros(1,cenarios);
dvpMA = zeros(1,cenarios);
dvpMAabs = zeros(1,cenarios);

for c = 1:cenarios
    % M�dia arit. das pot�ncias anuais ponderadas pelas horas de cada ano
    MA(1, c) = mean(PgerMWmAno(:, c));  
    
    % Permanencia de anos em que PgerWm ficou acima da MA.
    perMA(1, c) = (sum(PgerMWmAno(:, c) >= MA(1, c))/anos)*100;
    % Desvio dos res�duos em rela��o a MA ao quadrado
    dvpMA(1, c) = std((PgerMWmAno(:, c) - MA(1, c)).^2);
    % Desvio dos res�duos em rela��o a MA em m�dulo
    dvpMAabs(1, c) = std(abs(PgerMWmAno(:, c) - MA(1, c)));
end

%----- M�dia Harm�nica ponderada pelas horas nos meses
MH = zeros(1,cenarios);
perMH = zeros(1,cenarios);
dvpMH = zeros(1,cenarios);
dvpMHabs = zeros(1,cenarios);
for c = 1:cenarios
    % M�dia Harm�nica das pot�ncias anuais ponderada pelas horas dos anos
    MH(1, c) = harmmean(PgerMWmAno(:, c));  
    
    % Permanencia de anos em que PgerWm ficou acima da MA.
    perMH(1, c) = (sum(PgerMWmAno(:, c) >= MH(1, c))/anos)*100;
    % Desvio dos res�duos em rela��o a MA ao quadrado
    dvpMH(1, c) = std((PgerMWmAno(:, c) - MH(1, c)).^2);
    % Desvio dos res�duos em rela��o a MA em m�dulo
    dvpMHabs(1, c) = std(abs(PgerMWmAno(:, c) - MH(1, c)));
    
    % M�dia com � calculada na PoRTaria do MME
    MH(1, c) = harmmean(PgerMW(:, c));  
    % Permanencia de anos em que PgerWm ficou acima da MA.
    perMH(1, c) = (sum(PgerMW(:, c) >= MH(1, c))/l)*100;
    % Desvio dos res�duos em rela��o a MA ao quadrado
    dvpMH(1, c) = std((PgerMW(:, c) - MH(1, c)).^2);
    % Desvio dos res�duos em rela��o a MA em m�dulo
    dvpMHabs(1, c) = std(abs(PgerMW(:, c) - MH(1, c)));
end

% %----- M�dia Harm�nica ponderada pelas horas mensais e vaz�es anuais
% MHP = zeros(1,cenarios);
% perMHP = zeros(1,cenarios);
% dvpMHP = zeros(1,cenarios);
% dvpMHPabs = zeros(1,cenarios);
% 
% for c = 1:cenarios
%     %MHP =(sum(qAno)/sum(qAno./PgerMWmAno));
%     % M�dia com � calculada na PoRTaria do MME
%     MHP(1, c) = (sum(qAno)/sum(qAno./PgerMWmAno(:, c)));
%     % Permanencia de anos em que PgerWm ficou acima da MA.
%     perMHP(1, c) = (sum(PgerMWmAno(:, c) >= MHP(1, c))/anos)*100;
%     % Desvio dos res�duos em rela��o a MA ao quadrado
%     dvpMHP(1, c) = std((PgerMWmAno(:, c) - MHP(1, c)).^2);
%     % Desvio dos res�duos em rela��o a MA em m�dulo
%     dvpMHPabs(1, c) = std(abs(PgerMWmAno(:, c) - MHP(1, c)));
% end
% Impress�o de resutados
disp ('   ');
disp ('------------- M�DIAS --------------');
disp (['        Pinst=' num2str(PinstMW(1,1)) '     Pinst=' num2str(PinstMW(1,2)) '     Pinst=' num2str(PinstMW(1,3)) '     Pinst=' num2str(PinstMW(1,4))  '     Pinst=' num2str(PinstMW(1,5)) '     Pinst=' num2str(PinstMW(1,6))]);
disp(['MA_PRT= ' num2str(MA_PRT)]);
disp(['    MA= '       num2str(MA)]);
disp(['    MH= '       num2str(MH)]);
disp(['   MHP= '     num2str(MHP)]);
disp ('   ');

disp ('------------- PERMAN�NCIAS --------------');
disp (['           Pinst=' num2str(PinstMW(1,1)) '     Pinst=' num2str(PinstMW(1,2)) '     Pinst=' num2str(PinstMW(1,3)) '     Pinst=' num2str(PinstMW(1,4))  '     Pinst=' num2str(PinstMW(1,5)) '     Pinst=' num2str(PinstMW(1,6))]);
disp(['perMA_PRT= ' num2str(perMA_PRT)]);
disp(['    perMA= '   num2str(perMA)]);
disp(['    perMH= '      num2str(perMH)]);
disp(['   perMHP= '     num2str(perMHP)]);
disp ('   ');

disp ('------------- DESV. RES�DUOS AO QUADRADO ----------------');
disp (['           Pinst=' num2str(PinstMW(1,1)) '     Pinst=' num2str(PinstMW(1,2)) '     Pinst=' num2str(PinstMW(1,3)) '     Pinst=' num2str(PinstMW(1,4))  '     Pinst=' num2str(PinstMW(1,5)) '     Pinst=' num2str(PinstMW(1,6))]);
disp(['dvpMA_PRT= ' num2str(dvpMA_PRT)]);
disp(['    dvpMA= '   num2str(dvpMA)]);
disp(['    dvpMH= '     num2str(dvpMH)]);
disp(['   dvpMHP= '    num2str(dvpMHP)]);
disp ('   ');

disp ('------------- DESV. RES�DUOS EM M�DULO--------------');
disp (['              Pinst=' num2str(PinstMW(1,1)) '     Pinst=' num2str(PinstMW(1,2)) '     Pinst=' num2str(PinstMW(1,3)) '     Pinst=' num2str(PinstMW(1,4))  '     Pinst=' num2str(PinstMW(1,5)) '   Pinst=' num2str(PinstMW(1,6))]);
disp(['dvpMA_PRTabs= '    num2str(dvpMA_PRTabs)]);
disp(['    dvpMAabs= '           num2str(dvpMAabs)]);
disp(['    dvpMHabs= '           num2str(dvpMHabs)]);
disp(['   dvpMHPabs= '          num2str(dvpMHPabs)]);
disp ('-----------------------------');
%---------------------------

% desvio padr�o muito menor que a m�dia -> s�rie comportada 
% -> m�dia aritm�tica anual qAno
% disp(['  qAno  ', '    dvp_qAno ', 'coef.Var(%)', '   PgerWm 1',' PgerWm 2','  PgerWm 3','  PgerWm 4', '   dvpPgerAno']);
% disp([qAno, dvp_qAno, 100*(dvp_qAno./qAno), PgerMWmAno, dvpPgerAno]); 

% vMA = ones(anos,1)*MA;
% vMH = ones(anos,1)*MH;
% vMHP = ones(anos,1)*MHP;

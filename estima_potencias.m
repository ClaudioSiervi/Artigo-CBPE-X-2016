clear all
clc

filename = 'An�lises das Pot�ncias v3.xlsx';
sheet = 'Premissas';
xlPremissas = 'C3:H17';
premissas = xlsread(filename,sheet,xlPremissas);

[l, c] = size(premissas);

q = le_vazoes();

%rho = Premissas(7,1)
rho = 1000; % Massa espec�fica da �gua (Kg/m�)
g = 9.81;   % m�/s�

L = zeros(6,1);
for i=1:6
    nome = strcat('pch', int2str(i));
    L(i) = size(q.(nome), 1);
end

ANOS = floor(L./12);    % dim do hist�rico aflu�ncias (anos)

% pot�ncia instalada por usina (MW) 
PinstMW = ones(1, c)*30;


% xlPremissas = 'C3:H17';
% Premissas

rend = zeros(1,c);  % rendimento (%)
hl = zeros(1,c);    % queda l�quida (m)
qs = zeros(1,c);    % vaz�o sanit�ria (m�/s)
desc = zeros(1,c);  % descontos = (1-TEIF)*(1-IP)*(1-PerdasEletric)
for i = 1:c
    rend(1, i) = premissas(2,i);
    hl(1, i) = premissas(5,i);
    qs(1, i) = premissas(6,i);
    desc(1, i) = premissas(13,i);
end

% ni = Premissas(2,1); 
% hL = Premissas(5,1); 
% qS = Premissas(6,1);
% Desc = Premissas(13,1); 
    
H = Dados(:,1); % Horas
%q = Dados(:,3); % vaz�o

% Vetor de pot�ncias estimadas    
Pest = rho*g*hL*ni*(q-qS); % Pot�ncia Estimada (W)

Pinst = PinstMW.*1000000; %Convers�o MW -> W

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
    PgerMWh(:,i) = PgerMW(:,i).*H; % Pot�ncia Gerada (W)
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

qAno = zeros(anos,1); % Pot�ncia vezes vaz�o
dvp_qAno = zeros(anos,1);
for i=1:anos
     ini = 1 + (i-1)*12;
     fim = i*12;
    % Vaz�o m�dia anual
    qAno(i)= sum(q(ini:fim,1))/12;
    % Desvio padr�o da vaz�o  anual
    dvp_qAno(i) = std(q(ini:fim,1));
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
    % M�dia com � calculada na PoRTaria do MME
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
    % M�dia com � calculada na PoRTaria do MME
    MH(1, c) = harmmean(PgerMWmAno(:, c));  
    % Permanencia de anos em que PgerWm ficou acima da MA.
    perMH(1, c) = (sum(PgerMWmAno(:, c) >= MH(1, c))/anos)*100;
    % Desvio dos res�duos em rela��o a MA ao quadrado
    dvpMH(1, c) = std((PgerMWmAno(:, c) - MH(1, c)).^2);
    % Desvio dos res�duos em rela��o a MA em m�dulo
    dvpMHabs(1, c) = std(abs(PgerMWmAno(:, c) - MH(1, c)));
%     % M�dia com � calculada na PoRTaria do MME
%     MH(1, c) = harmmean(PgerMW(:, c));  
%     % Permanencia de anos em que PgerWm ficou acima da MA.
%     perMH(1, c) = (sum(PgerMW(:, c) >= MH(1, c))/l)*100;
%     % Desvio dos res�duos em rela��o a MA ao quadrado
%     dvpMH(1, c) = std((PgerMW(:, c) - MH(1, c)).^2);
%     % Desvio dos res�duos em rela��o a MA em m�dulo
%     dvpMHabs(1, c) = std(abs(PgerMW(:, c) - MH(1, c)));
end

%----- M�dia Harm�nica ponderada pelas horas mensais e vaz�es anuais
MHP = zeros(1,cenarios);
perMHP = zeros(1,cenarios);
dvpMHP = zeros(1,cenarios);
dvpMHPabs = zeros(1,cenarios);

for c = 1:cenarios
    %MHP =(sum(qAno)/sum(qAno./PgerMWmAno));
    % M�dia com � calculada na PoRTaria do MME
    MHP(1, c) = (sum(qAno)/sum(qAno./PgerMWmAno(:, c)));
    % Permanencia de anos em que PgerWm ficou acima da MA.
    perMHP(1, c) = (sum(PgerMWmAno(:, c) >= MHP(1, c))/anos)*100;
    % Desvio dos res�duos em rela��o a MA ao quadrado
    dvpMHP(1, c) = std((PgerMWmAno(:, c) - MHP(1, c)).^2);
    % Desvio dos res�duos em rela��o a MA em m�dulo
    dvpMHPabs(1, c) = std(abs(PgerMWmAno(:, c) - MHP(1, c)));
end
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

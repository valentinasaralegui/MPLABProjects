syms t
f = 5 % en Hz
w = 2*pi*f % pulsacion angular
func = laplace(sin(w*t))

[num den] = numden(func)
syms s
num = coeffs(num,s,'All')
num = eval(num)
den = coeffs(den,s,'All')
den = eval(den)

sys = tf(num,den)

figure(1)
impulse(sys,1)
hold on
step(sys,1)
hold off
title('Respuesta al impulso y escalon en el tiempo continuo')
legend("Impulso","Escalon")

% HS2_PLL16
% el cristal es de 12MHz
% si lo multiplicamos x16 y lo dividimos ÷2 nos da 96MHz
% una instruccion ocupa 4 ciclos de maquina
% entonces 96MHz ÷ 4 = 24MHz que es la frecuencia de instruccion
% Fcy = 24MHz
Fcy = 24e6
Tcy = 1/Fcy

sampleo = 200000*Tcy

% cada sampleo pone un valor de cuenta
% aproximadamente cada 0.0083 segundos

[numd dend] = c2dm(num,den,sampleo,'zoh')
sysd = tf(numd,dend,sampleo)

figure(2)
impulse(sysd,1)
hold on
step(sysd,1)
hold off
title("diferencia entre impulso y escalon digital")
legend("impulso","escalon")

% acá, para no perder tiempo, saqué el término de input[k] porque era multiplicar por 0

% vector de coeficientes NO Q15
coeficientes = [ -dend(2:end) numd(2:end) ]

% coeficientes =
% 
%           1.93185165257814                        -1       0.00108461463557334       0.00108461463557334
%
% para hacerlos fractional los vamos a dividir por 2

coeficientes = coeficientes / 2

% coeficientes =
% 
%      9.659258262890683e-01    -5.000000000000000e-01     5.423073177866694e-04     5.423073177866696e-04
%

filt(numd,dend,sampleo)

% Para el valor del PR1 del Timer1
%     si inv(24E6)=inv(Fcy) ----> 1Tcy
% entonces 200000*inv(24E6) ----> 200000Tcy
% como tenemos prescaler de 256
% el valor del PR1 es de
PR1 = round(sampleo/Tcy/256)
%%

% copio la salida del MPLABX y la guardo en una variable

% armo el vector de tiempos
% vas a ver que tiene parentesis y un ' al final
% es para que me lo deje vertcal como los datos que se pegaron del MPLABX
% sin eso, arma un vector horizontal
picTime = (0:sampleo:1)';


%% PARA ESTA SECCION YA SE DEBERIA HABER IMPLEMENTADO EN EL PIC

% veo que coinciden las dimensiones del vector de tiempos con el de datos
% extraidos del MPLABX

% abrimos las variables que copiamos del MPLABX al Matlab
load("usartCopiadas.mat");

% Ahora ploteo ambos step
% porque lo que hacemos en el MPLABX es un step
% ponemos la variable en 1 y recien la bajamos cuando termina un periodo

figure(3)
stairs(picTime,picStep,'LineWidth',1.5,'Color','red')
hold on
step(sysd,1)
step(sys,1)
hold off
title("ploteo del escalon del matlab junto con los datos del MPLABX")
legend("MPLABX","Matlab discreto","Matlab continuo")

% Ahora ploteamos ambos impulse
% corregido lo del impulso en el MPLABX
% ahora ploteamos ambos juntos

figure(4)
stairs(picTime,picImpulse,'LineWidth',1.5,'Color','red')
hold on
impulse(sysd,1)
impulse(sys,1)
hold off
title("ploteo del impulso del matlab junto con los datos del MPLABX")
legend("MPLABX","Matlab discreto","Matlab continuo")
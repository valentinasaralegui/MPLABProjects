syms t
laplace(t^2)
num = 2
den = [1 0 0 0]

sys = tf(num,den)

figure(1)
step(sys,2)
hold on
impulse(sys,2)
hold off
title("diferencia entre el impulso y el escalon")
legend("escalon","impuslo")

% Fcy = 24MHz
Fcy = 24e6
Tcy = 1/Fcy

sampleo = 500000*Tcy
% cada sampleo pone un valor de cuenta
% aproximadamente cada 0.0208 segundos

[numd dend] = c2dm(num,den,sampleo,'zoh')
sysd = tf(numd,dend,sampleo)

figure(2)
step(sysd,2)
hold on
impulse(sysd,2)
hold off
title("diferencia entre impulso y escalon digital")
legend("escalon","impulso")

filt(numd,dend)

% Mis coeficientes
% (son casi iguales, difieren en el ultimo digito

% numd =
% 
%                          0     3.014081790123459e-06     1.205632716049384e-05     3.014081790123456e-06
%                          
% dend =
% 
%      1    -3     3    -1

% copio la salida del MPLABX y la guardo en la variable pic

% armo el vector de tiempos
% vas a ver que tiene parentesis y un ' al final
% es para que me lo deje vertcal como los datos que se pegaron del MPLABX
% sin eso, arma un vector horizontal
picTime = (0:sampleo:2)';

% veo que coinciden las dimensiones del vector de tiempos con el de datos
% extraidos del MPLABX

% Ahora ploteo ambos step
% porque lo que hacemos en el MPLABX es un step
% ponemos la variable en 1 y recien la bajamos cuando termina un periodo

figure(3)
stairs(picTime,picStep,'LineWidth',1.5,'Color','red')
hold on
step(sysd,2)
hold off
title("ploteo del escalon del matlab junto con los datos del MPLABX")
legend("MPLABX","Matlab")

% Ahora ploteamos ambos impulse
% corregido lo del impulso en el MPLABX
% ahora ploteamos ambos juntos

figure(4)
stairs(picTime,picImpulse,'LineWidth',1.5,'Color','red')
hold on
impulse(sysd,2)
hold off
title("ploteo del impulso del matlab junto con los datos del MPLABX")
legend("MPLABX","Matlab")
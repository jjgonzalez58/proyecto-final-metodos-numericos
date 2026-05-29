clear
clc
close all

disp('==================================================')
disp('   INTERPOLACIÓN DE LAGRANGE (ENTRADA SECUENCIAL) ')
disp('==================================================')

% 1. Solicitar la cantidad de puntos conocidos
n = input('¿Cuántos puntos conocidos desea ingresar?: ');

% Validar que sea un número entero positivo válido
if isempty(n) || n <= 0 || mod(n,1) ~= 0
    error('Error: Debe ingresar un número entero positivo mayor a cero.');
end

% Inicializar los vectores vacíos para almacenar las coordenadas
x = zeros(1, n);
y = zeros(1, n);

% 2. Solicitar los puntos uno a uno en formato (x,y)
fprintf('\nPor favor, ingrese los puntos en el formato (x,y):\n');
for i = 1:n
    exito = false;
    while ~exito
        entrada = input(sprintf('  Punto %d: ', i), 's');
        
        % Expresión regular para extraer los números dentro o fuera de los paréntesis
        % Busca patrones numéricos (incluyendo decimales y signos negativos)
        numeros = regexp(entrada, '-?\d+\.?\d*', 'match');
        
        if length(numeros) == 2
            x(i) = str2double(numeros{1});
            y(i) = str2double(numeros{2});
            exito = true; 
        else
            disp(' -> Formato incorrecto. Asegúrese de usar el formato (x,y), por ejemplo: (2, 5) o (4,-5.5)');
        end
    end
end

% 3. Solicitar el punto X a interpolar
fprintf('\n');
xint = input('Ingrese el punto X que desea interpolar: ');

if isempty(xint)
    error('Error: Debe ingresar un valor numérico para interpolar.');
end


% --- ALGORITMO DE LAGRANGE ---
resultado = 0;
for i = 1:n
    % Polinomio base
    Li = 1;
    for j = 1:n
        if i ~= j
            Li = Li * ((xint - x(j)) / (x(i) - x(j)));
        end
    end
    resultado = resultado + (y(i) * Li);
end

% Resultado final
yint = resultado;

% Mostrar resultado en la consola
fprintf('\n==================================================\n');
fprintf('  El valor interpolado en X = %.4f es Y = %.4f\n', xint, yint);
fprintf('==================================================\n');


% --- GRAFICACIÓN ---
figure('Color', 'w', 'Name', 'Interpolación de Lagrange'); 

% 1. Graficar los puntos ingresados por el usuario
plot(x, y, 'bo', 'MarkerSize', 8, 'MarkerFaceColor', 'b')
hold on

% 2. Graficar punto interpolado (asterisco rojo)
plot(xint, yint, '*r', 'MarkerSize', 12, 'LineWidth', 2)


grid on
grid minor

% 4. Generación dinámica de la curva del Polinomio Completo, como
% referencia de ayuda visual
if n > 1
    margen = (max(x) - min(x)) * 0.1; 
    if margen == 0, margen = 1; end 
    
    x_curva = linspace(min(x) - margen, max(x) + margen, 200);
    y_curva = zeros(size(x_curva));

    % Calcular Lagrange para la curva continua
    for k = 1:length(x_curva)
        xk = x_curva(k);
        rk = 0;
        for i = 1:n
            Lik = 1;
            for j = 1:n
                if i ~= j
                    Lik = Lik * ((xk - x(j)) / (x(i) - x(j)));
                end
            end
            rk = rk + (y(i) * Lik);
        end
        y_curva(k) = rk;
    end

    % Graficar la curva polinómica completa
    plot(x_curva, y_curva, 'b-', 'LineWidth', 1.5)
    xlim([min(x)-margen, max(x)+margen]);
    xticks(linspace(min(x)-margen, max(x)+margen, 11));
end

% 5. Etiquetas y Leyendas
xlabel('Eje X (Variable Independiente)', 'FontSize', 12)
ylabel('Eje Y (Variable Dependiente)', 'FontSize', 12)
title('Interpolación Polinómica de Lagrange', 'FontSize', 14)

legend('Datos Conocidos (Nodos)', ...
       sprintf('Punto Interpolado (%.2f, %.2f)', xint, yint), ...
       'Polinomio Interpolador de Lagrange', ...
       'Location', 'best')

hold off
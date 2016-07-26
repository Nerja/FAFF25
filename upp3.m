function [] = upp3()
    fresnelvsfraun(100*10^-6, 632*10^-9);
end

function [] = fresnelvsfraun(b, lambda)
    hFig = figure(1);%S‰kerst‰ller l‰mplig storlek
    set(hFig, 'Position', [0 0 1100 900]); %S‰kerst‰ller l‰mplig storlek
    
    subplot(2,2,1);                        %Plottar för 1m
    doplot(b, lambda, 1, 0.10);
    ylim([0,1]);

    subplot(2,2,2);                        %Plottar för 10cm
    doplot(b, lambda, 0.1, 0.005);
    ylim([0,1]);
    
    subplot(2,2,3);
    doplot(b, lambda, 0.01, 0.0005);               %Plottar för 1cm
    ylim([0,1]);

    subplot(2,2,4);                        %Plotta för 1mm
    doplot(b, lambda, 0.001, 0.0005);
    ylim([0, 0.1]);     %Ignorera att visa en absoluta toppen ser inte
                        %andra intressanta saker då
end

function [] = doplot(b,lambda,L, screenDim)
    xlim =screenDim/2;                  %Ta fram för vilka x det är lämpligt
    x = linspace(-xlim, xlim, 1000);             %Generera intervall av x värden
    beta = ((pi*b)/lambda).*(x./L);        %Ta fram beta
    inten = (sin(beta)./beta).^2;          %Beräkna intensitetsvärden
    plot(x.*100, inten, 'g');                   %Plotta intensitet som funktion av x
                                           %i enheten cm.
    hold on
    title(strcat(strcat('Intensitet för L =  ', num2str(L)),' m'));
    xlabel('Avstånd x (cm)');
    ylabel('Intensitet');
    doplot2(x, b, lambda, L);
    legend('Intensitetsfördelning Fraun','Intensitetsfördelning Fresnel');
end

function [] = doplot2(x, b, lambda, L)
    fresint = zeros(numel(x), 1);   %Skapa plats för intensitet för varje x
    for i = 1:numel(fresint)        %För varje x beräkna intensiteten
        fresint(i) = fresx(x(i), b, lambda, L);
    end
    plot(x.*100, fresint,'-.');     %Skala om till cm
end

function [intx] = fresx(x,b,lambda,L)
    N = 10000;          %Dela upp spalten i 10000
    n = -N/2:1:N/2;     %Skapa n
    gangv = (L^2 + (x - n.*(b/N)).^2).^0.5; %För varje segment beräkna
                                            %den optiska gågna vägen
    psi = (gangv./lambda)*2*pi;             %Omvandla optiska gångvägen tillfasfˆrskutning
    dx = cos(psi).*(1/N);                   %Beräkna realdelarna för alla komplexa bidrag
    dy = sin(psi).*(1/N);                   %Beräkna imgdelarna för alla komplexa bidrag
    dxsum = sum(dx);                        %Summera alla realdelar
    dysum = sum(dy);                        %Summera alla imgdelar
    intx = dxsum^2 + dysum^2;               %Intensiteten för totalamp^2
end


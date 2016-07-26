function [] = upp3()
    fresnelvsfraun(100*10^-6, 632*10^-9);
end

function [] = fresnelvsfraun(b, lambda)
    hFig = figure(1);%S�kerst�ller l�mplig storlek
    set(hFig, 'Position', [0 0 1100 900]); %S�kerst�ller l�mplig storlek
    
    subplot(2,2,1);                        %Plottar f�r 1m
    doplot(b, lambda, 1, 0.10);
    ylim([0,1]);

    subplot(2,2,2);                        %Plottar f�r 10cm
    doplot(b, lambda, 0.1, 0.005);
    ylim([0,1]);
    
    subplot(2,2,3);
    doplot(b, lambda, 0.01, 0.0005);               %Plottar f�r 1cm
    ylim([0,1]);

    subplot(2,2,4);                        %Plotta f�r 1mm
    doplot(b, lambda, 0.001, 0.0005);
    ylim([0, 0.1]);     %Ignorera att visa en absoluta toppen ser inte
                        %andra intressanta saker d�
end

function [] = doplot(b,lambda,L, screenDim)
    xlim =screenDim/2;                  %Ta fram f�r vilka x det �r l�mpligt
    x = linspace(-xlim, xlim, 1000);             %Generera intervall av x v�rden
    beta = ((pi*b)/lambda).*(x./L);        %Ta fram beta
    inten = (sin(beta)./beta).^2;          %Ber�kna intensitetsv�rden
    plot(x.*100, inten, 'g');                   %Plotta intensitet som funktion av x
                                           %i enheten cm.
    hold on
    title(strcat(strcat('Intensitet f�r L =  ', num2str(L)),' m'));
    xlabel('Avst�nd x (cm)');
    ylabel('Intensitet');
    doplot2(x, b, lambda, L);
    legend('Intensitetsf�rdelning Fraun','Intensitetsf�rdelning Fresnel');
end

function [] = doplot2(x, b, lambda, L)
    fresint = zeros(numel(x), 1);   %Skapa plats f�r intensitet f�r varje x
    for i = 1:numel(fresint)        %F�r varje x ber�kna intensiteten
        fresint(i) = fresx(x(i), b, lambda, L);
    end
    plot(x.*100, fresint,'-.');     %Skala om till cm
end

function [intx] = fresx(x,b,lambda,L)
    N = 10000;          %Dela upp spalten i 10000
    n = -N/2:1:N/2;     %Skapa n
    gangv = (L^2 + (x - n.*(b/N)).^2).^0.5; %F�r varje segment ber�kna
                                            %den optiska g�gna v�gen
    psi = (gangv./lambda)*2*pi;             %Omvandla optiska g�ngv�gen tillfasf�rskutning
    dx = cos(psi).*(1/N);                   %Ber�kna realdelarna f�r alla komplexa bidrag
    dy = sin(psi).*(1/N);                   %Ber�kna imgdelarna f�r alla komplexa bidrag
    dxsum = sum(dx);                        %Summera alla realdelar
    dysum = sum(dy);                        %Summera alla imgdelar
    intx = dxsum^2 + dysum^2;               %Intensiteten f�r totalamp^2
end


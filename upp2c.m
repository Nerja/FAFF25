function [] = upp2c()
    sfariskkrom(0.15, 0.05, 400, 700);
end

function [] = sfariskkrom(R, h, l1, l2)
    if(h > R)
        error('Du måste ha h < R');
    elseif(l1 >= l2)
        error('Du måste ha l2 > l1');
    end
    lambdau = linspace(l1, l2).*(10^-3); %Skapar intervallet x1 um till x2 um.
    n = nvalues(l1, l2, lambdau);
    f = h./tan(asin(h/R)-asin(h./(n.*R))) - R*cos(asin(h/R)) + R;   %fokus för olika våglängder
    disp(size(f));
    plot(lambdau.*10^3, f);                    %Ritar ut focus som func av höjd
    title('Kromatiska abberation');   
    xlabel('Våglängd (nm)')            
    ylabel('Fokus (m)')            
    xlim([l1, l2]);                
    ylim('auto');                  
end

function [n] = nvalues(x1, x2, lambdau)
    a = [2.271176, -9.700709*10^-3, 0.0110971, 4.622809*10^-5, 1.616105*10^-5, -8.285043*10^-7];
    n = zeros(numel(lambdau), 1); %Skapar vektor att lägga brytningsindex i
    for i = 1:numel(lambdau)           %Går igenom alla värden i lambdau och beräknar brytningsindex
        e = lambdau(i);
        lambdauserie = [1, e^2, e^-2, e^-4, e^-6, e^-8];
        n(i) = (a*transpose(lambdauserie))^0.5;
    end
end
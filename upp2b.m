function [] = upp2b() 
    bk7index(400, 700);
end

function [] = bk7index(x1, x2)
    if(x1 >= x2)
      error('Du måste ha x2 > x1');
    end
    a = [2.271176, -9.700709*10^-3, 0.0110971, 4.622809*10^-5, 1.616105*10^-5, -8.285043*10^-7];
    lambdau = linspace(x1, x2)*10^-3; %Skapar intervall x1 um till x2 um.
    nvalues = zeros(numel(lambdau), 1); %Skapar vektor att lägga brytningsindex i
    for i = 1:numel(lambdau)           %Går igenom alla värden i lambdau och beräknar brytningsindex
        e = lambdau(i);
        lambdauserie = [1, e^2, e^-2, e^-4, e^-6, e^-8];
        nvalues(i) = (a*transpose(lambdauserie))^0.5;
    end
    plot(lambdau.*10^3, nvalues)  %Plottar brytningsindex som funktion av våglängd
                                 %Skalar tillbaka till nm av
                                 %bekvämlighetsskäl.
    ylabel('Brytningsindex');
    xlabel('Våglängd i nm');
    title('Brytningsindex som funktion av våglängd');
    xlim([x1, x2]) %Skala om xaxeln lite snyggt
end
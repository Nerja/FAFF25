function [] = upp2a() 
    sfariskabbr(0.15, 1.5, 0.1);
end 

function [] = sfariskabbr(R, n, D)
    if(R <= 0) 
        error('Du måste ha R > 0');
    elseif(n <= 0) 
        error('Du måste ha n > 0');
    elseif(D >= R)
        error('Du måste ha D < R');
    elseif(D <= 0)
        error('Du måste ha D > 0');
    end
    h = linspace(10^-6, D/2); %skapar jämt utspridda h 
    
    f = h./tan(asin(h/R)-asin(h/(n*R))) - R.*cos(asin(h/R)) + R;  %beräknar focus för alla h
    ft = (n*R)/(n-1);   %beräkna "teoretiskt focus"
    ftarr = ones(length(h)).*ft;   %skapa punkter för teoretiskt fokus
    plot(h, f);                    %ritar ut fokus som func av höjd
    title('Sfärisk abberation'); 
    hold on                        
    plot(h, ftarr, 'r');           %ritar ut teoretiskt focus
    xlabel('Höjd (m)')            
    ylabel('Fokus (m)')            
    legend('Exakt fokus', 'Approximativ fokus')  
    scale = (f(2)-f(length(f)))*(1/16);     
    ylim([f(length(f)), ft+scale]);     
end


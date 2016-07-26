function [] = upp1() 
    figure(1);
    brytning(1, 1.5);
    figure(2);
    brytning(1.75, 1);
end

function [] = brytning(n1, n2)
    totalref = 0;               
    if(n2/n1 < 1)               %Req for total reflection
       totalref = asin(n2/n1)   %Total reflection angle
    else
        totalref = pi/2;        
    end                        
    a1 = linspace(0, totalref);   
    a2 = asin((n1.*sin(a1))./n2);  %Snell
    rs = (sin(a1-a2)./sin(a1+a2)).^2; 
    rp = (tan(a1-a2)./tan(a1+a2)).^2; 
    brewsterg = radtodeg(atan(n2/n1)); %Computes brewster
    a1deg = radtodeg(a1);       
    plot(a1deg, rs);           
    hold on
    plot(a1deg, rp, 'r');      
    hold on
    plot([brewsterg brewsterg], [0 1.02], 'black'); %Shows brewster angle
    brewstring = strcat(strcat('Brewster vinkel(',num2str(brewsterg)),'\circ)');
    if(n2/n1 < 1)               
        hold on                 
        totalrefg = radtodeg(totalref);
        plot([totalrefg totalrefg], [0 1.02], 'g');
        plot([totalrefg, 90], [1 1], 'b');
        plot([totalrefg, 90], [1 1], 'r');
        totalrefstring = strcat(strcat('Total reflektion(',num2str(totalrefg)),'\circ)');
        legend('Vinkelrät ljus(r_s)','Parallellt ljus(r_p)',brewstring,totalrefstring);
    else 
        legend('Vinkelrät ljus(r_s)','Parallellt ljus(r_p)',brewstring);
    end
    title(strcat(strcat(strcat('Brytning med n1 = ', num2str(n1)), ' och n2 = '),num2str(n2)));
    axis([0,90,0,1.02]);   
    xlabel('Infallande vinkel i grader \circ');
    ylabel('Reflektion i %');
end


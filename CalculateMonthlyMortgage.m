%The Function that is called on when doing question 3
function[MonthlyMortgage]= CalculateMonthlyMortgage(V,d,r,n)
P= V * (1-d/100); %Principal amount found from the total multiplied by the percent of down payment
i= r/1200; %monthly interest rate
nMonths= n*12; %total num of payments made
m= P*i*(1+i)^nMonths/((1+i)^nMonths-1) ; %The monthly mortgage price
MonthlyMortgage=m; 
end
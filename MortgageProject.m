c=fred; % fred is the federal reserve economic data
MortgageData= fetch(c, 'MORTGAGE30US', datetime('today')-years(5), datetime('today')); 
% This finds the 30 year mortgage data in the US for the past 5 years
dateStrings= datestr(MortgageData.Data(:,1), 'dd-mmm-yyyy'); 
% This is to simply produce an easier to read formatting for column one of
% MortgageData.Data, putting it into a day-month-year format
newData= table(dateStrings, MortgageData.Data(:,2), 'VariableNames', {'Date','MortgageRate'}); 
% This creates a new table, using our new easier to read formatting of
% dates, with the corresponding Mortgage rates
%% Question 1
xData= datenum(newData.Date); 
% datenum serializes the date 
plot(xData,newData.MortgageRate);
% This plots the serialized date number as x and the mortgage rate as y
datetick('x', 'dd-mmm-yyyy');
% This turns the serialized dates into date formatted tick labels for the x
% axis
[maxRate, maxIndex] = max(newData.MortgageRate); %This finds the maximum value of mortgage rates
[minRate, minIndex] = min(newData.MortgageRate); %Finds the minimum value of mortgage rates
hold on; %this adds the marker to the existing plot
scatter(xData(maxIndex), maxRate, 50, 'filled', 'DisplayName', 'Peak');
%This adds the marker to the plot and names it the peak
%The peak was the week of the 27th of October, 2022
scatter(xData(minIndex), minRate, 50, 'filled', 'DisplayName', 'Low');
%Adds a marker to the plot and names it low
%This low was the week of the 7th of January, 2021
legend(); %adds a legend to the plot
hold on
xlabel('Week')
ylabel('Mortgage Rate')
title('30 Year Mortgage Rate in The US for the Past 5 Years')

%% Question 2
% V= housing price
% d= downpayment %
% r= yearly interest rate
% n=years
%P= principle amount

%P= V * (1-d/100); the principle amount is found my mutiplying the price by
%the downpayment subtracted from 100%
%i= r/1200; monthly interest rate
% nMonths= n*12; the total num of payments made, as it is months not years
% m= P*i*(1+i)^nMonths/((1+i)^nMonths-1) ; The monthly mortgage payment,
% found from multiplying the principle amount by the monthly interest rate and then by total interest rate
% for each compounding period, divided by the total interest rate for each
% compounding period subtracted by the present value of the first payment

%% Question 3
V= input('Enter the Housing Price: '); 
d= input('Enter the down payment percentage: ');
r= input('Enter the yearly interest rate: ');
n= input('Enter the number of years: ');
MonthlyMortgage = CalculateMonthlyMortgage(V,d,r,n);
fprintf ('Your Monthly Mortgage Payment Is $%.2f\n', MonthlyMortgage);

%% Question 4
% This calculation will output the amount paid in both interest and
% principal on a monthly basis
%Data from calculatemonthlymortgage function
nMonths= n*12; 
P= V * (1-d/100);
i = r/1200;
m= P*i*(1+i)^nMonths/((1+i)^nMonths-1) ;
interest = zeros (1,nMonths);
principal = zeros (1,nMonths);
% creates a zeros array with the data from how many months included for
% both interest and principal
balance = P; %sets the balance equal to the principal amount
k=1;  %initialize countervariable
for k= 1:nMonths %for loop that finds the balance
    interest(k) = balance * i; % interest in reference to the countervariable, which is found by multiplying the current balance by the monthly interest rate
    principal(k) = m - interest(k); % the principal of the countervariable, found by subtracting the interest of the counter from the monthly mortgage payment
    balance = balance - principal(k); %new balance found from subtracting the principal of the counter from the previously found balance
end
%Plotting the interest and principal monthly payments
figure(2) % creates a new figure so the previous is not overwritten
plot(interest, 'r') %plots the interest line as red
hold on
plot(principal, 'b') %plots the principal line as blue
xlabel('Month')
ylabel('Amount')
title('Interest and Principal Monthly Payments')
legend ('Interest', 'Principal')
 % For calculating the amount paid after n/2 years
 half_N= nMonths/2; %half of n years
 paid_off= P - balance; % The principal minus the new balance
 fprintf('You have paid off $%.2f of your mortgage by year %.1f.\n', paid_off,half_N/12); 
 %% Question 5
 %amount of interest paid through duration of mortgage
 TI= m * nMonths - P; %Total interest is found through the monthly mortgage payments, times the number of payments, minus the principal
 fprintf('Total interest paid over the duration of the mortgage is $%.2f\n',TI);
 %% Question 6
 S= input('Enter the Windfall Amount: ');
 o= nMonths - 36; %Finds the number of months left after 36 have passed
 u= P*(1+i)^(-36)-S*(1+i)^(-36); %This finds the new principal amount after the windfall is applied
 M= (i*u)/(1-(1+i)^(-o)); % This equation finds the new monthly mortgage payment beginning on month 37
 fprintf('Your New Monthly Payment After the Windfall is $%.2f\n', M);
 
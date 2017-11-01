clear all; close all; 
X=dlmread('housing_price_data.dat');
F=sortrows([X(:,5) X(:,2)]);
figure; 
scatter(F(:,1), F(:,2)); 
title('Scatter plot of housing prices'); 
xlabel('Size in square Feet'); 
ylabel('Price');
F=F(25:600,:);   % size 576x2 
Size_of_house=F(:,1); 
normalize = max(Size_of_house)-min(Size_of_house);
normlized_size = Size_of_house/normalize;
%X = [repmat(1,length(F),1) X];
y=F(:,2);
w0=0;
w1=0;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
% Parameters 
%   X = 576   [size_of_house] 
%   y = 576x1 %   w = 2x1 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
% Initialize learning rate 
learning_rate = 0.15;   % play with this parameter 
i=1;
cost=0;
error=zeros(1,1);
while true
  temp0=w0-(learning_rate*((1/576)*(sum(w0+w1*normlized_size-y))));
  temp1=w1-(learning_rate*((1/576)*(sum((w0+w1*normlized_size-y).*normlized_size))));
  w0=temp0;
  w1=temp1;
  
  f=w0+ (w1*normlized_size);
  cost=(1/(2*576))*(sum((f-y).^2));
  error(i)=cost;
  
  if(i~=1 && (error(i-1)-error(i))<0.5)
      break;
  end
    
  i=i+1;
  error=[error;zeros(1,1)];
end
figure;
hold off;
scatter(Size_of_house,y,5);
hold;
plot(Size_of_house,f,'r');
xlabel('Size in square Feet'); 
ylabel('Price');
figure; 
plot(error);
xlabel('Iterations');
ylabel('Error');
fprintf('Algorithm converges after %d iterations, learning rate=%5.3f \n', i,learning_rate);
w0
w1
clc 
close all
%% Import data from text file.
% Script for importing data from the following text file:
%
%    /Users/nadaehab/Downloads/heart_DD (1).csv
%
% To extend the code to different selected data or a different text file,
% generate a function instead of a script.

% Auto-generated by MATLAB on 2019/02/16 17:35:46

%% Initialize variables.
filename = '/Users/nadaehab/Downloads/heart_DD (1).csv';
delimiter = ',';
startRow = 2;

%% Format string for each line of text:
%   column1: double (%f)
%	column2: double (%f)
%   column3: double (%f)
%	column4: double (%f)
%   column5: double (%f)
%	column6: double (%f)
%   column7: double (%f)
%	column8: double (%f)
%   column9: double (%f)
%	column10: double (%f)
%   column11: double (%f)
%	column12: double (%f)
%   column13: double (%f)
%	column14: double (%f)
% For more information, see the TEXTSCAN documentation.
formatSpec = '%f%f%f%f%f%f%f%f%f%f%f%f%f%f%[^\n\r]';

%% Open the text file.
fileID = fopen(filename,'r');

%% Read columns of data according to format string.
% This call is based on the structure of the file used to generate this
% code. If an error occurs for a different file, try regenerating the code
% from the Import Tool.
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'HeaderLines' ,startRow-1, 'ReturnOnError', false);

%% Close the text file.
fclose(fileID);

%% Post processing for unimportable data.
% No unimportable data rules were applied during the import, so no post
% processing code is included. To generate code which works for
% unimportable data, select unimportable cells in a file and regenerate the
% script.

%% Allocate imported array to column variable names
age = dataArray{:, 1};
sex = dataArray{:, 2};
cp = dataArray{:, 3};
trestbps = dataArray{:, 4};
chol1 = dataArray{:, 5};
fbs = dataArray{:, 6};
restecg = dataArray{:, 7};
thalach = dataArray{:, 8};
exang = dataArray{:, 9};
oldpeak = dataArray{:, 10};
slope = dataArray{:, 11};
ca = dataArray{:, 12};
thal = dataArray{:, 13};
target = dataArray{:, 14};

data=[age,sex,cp,trestbps,chol1,fbs,restecg,thalach,exang,oldpeak,slope,ca,thal,target];
S=data(1:150,1:13);
SCV=data(151:200,1:13);
ST=data(201:250,1:13);
TargetTraining=data(1:150,14);
TargetCV=data(151:200,14);
TargetTest=data(201:250,14);

m=length(S(:,1));
m2=length(SCV(:,1));
m3=length(ST(:,1));

alphaH1=0.25;
alphaH2=0.5;
alphaH3=0.35;
alphaH4=0.1;

Y=TargetTraining/mean(TargetTraining);
YCV=TargetCV/mean(TargetCV);
YTest=TargetTest/mean(TargetTest);
%% HYPOTHESIS 1 Poly age & sex linear > restach thalach
P1=[S(:,1:10)];
P2=[S(:,11:13)];
P1C=[SCV(:,1:10)];
P2C=[SCV(:,11:13)];
P1T=[ST(:,1:10)];
P2T=[ST(:,11:13)];
hypothesis21=featureNormalizeLog([P1,P2,P1.^2]);
hypothesis21=[ones(m,1),hypothesis21];
hypothesis21C=featureNormalizeLog([P1C,P2C,P1C.^2]);
hypothesis21C=[ones(m2,1),hypothesis21C];
theta21=zeros(size(hypothesis21,2),1);
hypothesis22=featureNormalizeLog([P1,P2,P1.^2,P1.^3,P1.^4]);
hypothesis22=[ones(m,1),hypothesis22];
hypothesis22C=featureNormalizeLog([P1C,P2C,P1C.^2,P1C.^3,P1C.^4]);
hypothesis22C=[ones(m2,1),hypothesis22C];
theta22=zeros(size(hypothesis22,2),1);
hypothesis23=featureNormalizeLog([P1,P2,P1.^2,P1.^3,P1.^4,P1.^5,P1.^6]);
hypothesis23=[ones(m,1),hypothesis23];
hypothesis23C=featureNormalizeLog([P1C,P2C,P1C.^2,P1C.^3,P1C.^4,P1C.^5,P1C.^6]);
hypothesis23C=[ones(m2,1),hypothesis23C];
theta23=zeros(size(hypothesis23,2),1);
hypothesis24=featureNormalizeLog([P1,P2,P1.^2,P1.^3,P1.^4,P1.^5,P1.^6,P1.^7,P1.^8]);
hypothesis24=[ones(m,1),hypothesis24];
hypothesis24C=featureNormalizeLog([P1C,P2C,P1C.^2,P1C.^3,P1C.^4,P1C.^5,P1C.^6,P1C.^7,P1C.^8]);
hypothesis24C=[ones(m2,1),hypothesis24C];
hypothesis2T=featureNormalizeLog([P1T,P2T,P1T.^2,P1T.^3,P1T.^4]);
hypothesis2T=[ones(m2,1),hypothesis2T];
theta24=zeros(size(hypothesis24,2),1);
initialCostH1=CostFunctionLogistic(hypothesis21,Y,theta21)
[thetaH21, J_historyH21]=GradientDescentLogistic(hypothesis21,Y,theta21,alphaH1,initialCostH1);
[thetaH22, J_historyH22]=GradientDescentLogistic(hypothesis22,Y,theta22,alphaH1,initialCostH1);
[thetaH23, J_historyH23]=GradientDescentLogistic(hypothesis23,Y,theta23,alphaH1,initialCostH1);
[thetaH24, J_historyH24]=GradientDescentLogistic(hypothesis24,Y,theta24,alphaH1,initialCostH1);
figure(2);
plot(1:length(J_historyH21), J_historyH21, '-b');
xlabel('Number of iterations');
ylabel('Cost J')
title('Hypothesis2');

finalCostH21=CostFunctionLogistic(hypothesis21C,YCV,thetaH21)
finalCostH22=CostFunctionLogistic(hypothesis22C,YCV,thetaH22)
finalCostH23=CostFunctionLogistic(hypothesis23C,YCV,thetaH23)
finalCostH24=CostFunctionLogistic(hypothesis24C,YCV,thetaH24)
figure(4);
plot(2:2:8,[finalCostH21,finalCostH22,finalCostH23,finalCostH24]);
xlabel('Polynomial degree');
ylabel('Error');
title('Hypothesis2');

%Chosen Degree 4
TestCostH21=CostFunctionLogistic(hypothesis2T,YTest,thetaH22)

%% HYPOTHESIS2 Poly age trestbps2 chol3 Linear> sex cp fbps rst exang oldpeak
P1=[S(:,1),S(:,4:5)];
P2=[S(:,2:3),S(:,6:7),S(:,9:13)];
P1C=[SCV(:,1),SCV(:,4:5)];
P2C=[SCV(:,2:3),SCV(:,6:7),SCV(:,9:13)];
P1T=[ST(:,1),ST(:,4:5)];
P2T=[ST(:,2:3),ST(:,6:7),ST(:,9:13)];
hypothesis11=featureNormalizeLog([P1,P2,P1.^2]);
hypothesis11=[ones(m,1),hypothesis11];
hypothesis11C=featureNormalizeLog([P1C,P2C,P1C.^2]);
hypothesis11C=[ones(m2,1),hypothesis11C];
theta11=zeros(size(hypothesis11,2),1);
hypothesis12=featureNormalizeLog([P1,P2,P1.^2,P1.^3,P1.^4]);
hypothesis12=[ones(m,1),hypothesis12];
hypothesis12C=featureNormalizeLog([P1C,P2C,P1C.^2,P1C.^3,P1C.^4]);
hypothesis12C=[ones(m2,1),hypothesis12C];
theta12=zeros(size(hypothesis12,2),1);
hypothesis13=featureNormalizeLog([P1,P2,P1.^2,P1.^3,P1.^4,P1.^5,P1.^6]);
hypothesis13=[ones(m,1),hypothesis13];
hypothesis13C=featureNormalizeLog([P1C,P2C,P1C.^2,P1C.^3,P1C.^4,P1C.^5,P1C.^6]);
hypothesis13C=[ones(m2,1),hypothesis13C];
theta13=zeros(size(hypothesis13,2),1);
hypothesis14=featureNormalizeLog([P1,P2,P1.^2,P1.^3,P1.^4,P1.^5,P1.^6,P1.^7,P1.^8]);
hypothesis14C=featureNormalizeLog([P1C,P2C,P1C.^2,P1C.^3,P1C.^4,P1C.^5,P1C.^6,P1C.^7,P1C.^8]);
hypothesis14=[ones(m,1),hypothesis14];
hypothesis14C=[ones(m2,1),hypothesis14C];
hypothesis1T=featureNormalizeLog([P1T,P2T,P1T.^2,P1T.^3,P1T.^4,P1T.^5,P1T.^6,P1T.^7,P1T.^8]);
hypothesis1T=[ones(m3,1),hypothesis1T];

theta14=zeros(size(hypothesis14,2),1);
initialCostH1=CostFunctionLogistic(hypothesis11,Y,theta11)
[thetaH11, J_historyH11]=GradientDescentLogistic(hypothesis11,Y,theta11,alphaH2,initialCostH1);
[thetaH12, J_historyH12]=GradientDescentLogistic(hypothesis12,Y,theta12,alphaH2,initialCostH1);
[thetaH13, J_historyH13]=GradientDescentLogistic(hypothesis13,Y,theta13,alphaH2,initialCostH1);
[thetaH14, J_historyH14]=GradientDescentLogistic(hypothesis14,Y,theta14,alphaH2,initialCostH1);
figure(1);
plot(1:length(J_historyH13), J_historyH13, '-b');
xlabel('Number of iterations');
ylabel('Cost J')
title('Hypothesis1');

finalCostH11=CostFunctionLogistic(hypothesis11C,YCV,thetaH11)
finalCostH12=CostFunctionLogistic(hypothesis12C,YCV,thetaH12)
finalCostH13=CostFunctionLogistic(hypothesis13C,YCV,thetaH13)
finalCostH14=CostFunctionLogistic(hypothesis14C,YCV,thetaH14)
figure(2);
plot(2:2:8,[finalCostH11,finalCostH12,finalCostH13,finalCostH14]);
xlabel('Polynomial degree');
ylabel('Error');
title('Hypothesis1');

%Chosen Degree 8
TestCostH11=CostFunctionLogistic(hypothesis1T,YTest,thetaH14)
%% Hypothesis 3 
P1=[S(:,5),S(:,8)];
P2=[S(:,1:4),S(:,6:7),S(:,9:13)];
P1C=[SCV(:,5),SCV(:,8)];
P2C=[SCV(:,1:4),SCV(:,6:7),SCV(:,9:13)];
P1T=[ST(:,5),ST(:,8)];
P2T=[ST(:,1:4),ST(:,6:7),ST(:,9:13)];
hypothesis31=featureNormalizeLog([P1,P2,P1.^2]);
hypothesis31=[ones(m,1),hypothesis31];
hypothesis31C=featureNormalizeLog([P1C,P2C,P1C.^2]);
hypothesis31C=[ones(m2,1),hypothesis31C];
theta31=zeros(size(hypothesis31,2),1);
hypothesis32=featureNormalizeLog([P1,P2,P1.^2,P1.^3,P1.^4]);
hypothesis32=[ones(m,1),hypothesis32];
hypothesis32C=featureNormalizeLog([P1C,P2C,P1C.^2,P1C.^3,P1C.^4]);
hypothesis32C=[ones(m2,1),hypothesis32C];
theta32=zeros(size(hypothesis32,2),1);
hypothesis33=featureNormalizeLog([P1,P2,P1.^2,P1.^3,P1.^4,P1.^5,P1.^6]);
hypothesis33=[ones(m,1),hypothesis33];
hypothesis33C=featureNormalizeLog([P1C,P2C,P1C.^2,P1C.^3,P1C.^4,P1C.^5,P1C.^6]);
hypothesis33C=[ones(m2,1),hypothesis33C];
theta33=zeros(size(hypothesis33,2),1);
hypothesis34=featureNormalizeLog([P1,P2,P1.^2,P1.^3,P1.^4,P1.^5,P1.^6,P1.^7,P1.^8]);
hypothesis34=[ones(m,1),hypothesis34];
hypothesis34C=featureNormalizeLog([P1C,P2C,P1C.^2,P1C.^3,P1C.^4,P1C.^5,P1C.^6,P1C.^7,P1C.^8]);
hypothesis34C=[ones(m2,1),hypothesis34C];
hypothesis3T=featureNormalizeLog([P1T,P2T,P1T.^2,P1C.^3,P1C.^4,P1C.^5,P1C.^6,P1C.^7,P1C.^8]);
hypothesis3T=[ones(m3,1),hypothesis3T];
theta34=zeros(size(hypothesis34,2),1);
initialCostH3=CostFunctionLogistic(hypothesis31,Y,theta31)
[thetaH31, J_historyH31]=GradientDescentLogistic(hypothesis31,Y,theta31,alphaH3,initialCostH1);
[thetaH32, J_historyH32]=GradientDescentLogistic(hypothesis32,Y,theta32,alphaH3,initialCostH1);
[thetaH33, J_historyH33]=GradientDescentLogistic(hypothesis33,Y,theta33,alphaH3,initialCostH1);
[thetaH34, J_historyH34]=GradientDescentLogistic(hypothesis34,Y,theta34,alphaH3,initialCostH1);
figure(5);
plot(1:length(J_historyH33), J_historyH33, '-b');
xlabel('Number of iterations');
ylabel('Cost J')
title('Hypothesis3');

finalCostH31=CostFunctionLogistic(hypothesis31C,YCV,thetaH31)
finalCostH32=CostFunctionLogistic(hypothesis32C,YCV,thetaH32)
finalCostH33=CostFunctionLogistic(hypothesis33C,YCV,thetaH33)
finalCostH34=CostFunctionLogistic(hypothesis34C,YCV,thetaH34)
figure(6);
plot(2:2:8,[finalCostH31,finalCostH32,finalCostH33,finalCostH34]);
xlabel('Polynomial degree');
ylabel('Error');
title('Hypothesis3');

%Chosen Degree 8
TestCostH31=CostFunctionLogistic(hypothesis3T,YTest,thetaH34)


%% Hypothesis 4
P1=[S(:,5)];
P2=[S(:,1:4),S(:,6:13)];
P1C=[SCV(:,5)];
P2C=[SCV(:,1:4),SCV(:,6:13)];
P1T=[ST(:,5)];
P2T=[ST(:,1:4),ST(:,6:13)];
hypothesis41=featureNormalizeLog([P1,P2,P2.^2]);
hypothesis41=[ones(m,1),hypothesis41];
hypothesis41C=featureNormalizeLog([P1C,P2C,P2C.^2]);
hypothesis41C=[ones(m2,1),hypothesis41C];
theta41=zeros(size(hypothesis41,2),1);
hypothesis42=featureNormalizeLog([P1,P2,P2.^2,P2.^3,P2.^4]);
hypothesis42=[ones(m,1),hypothesis42];
hypothesis42C=featureNormalizeLog([P1C,P2C,P2C.^2,P2C.^3,P2C.^4]);
hypothesis42C=[ones(m2,1),hypothesis42C];
theta42=zeros(size(hypothesis42,2),1);
hypothesis43=featureNormalizeLog([P1,P2,P2.^2,P2.^3,P2.^4,P2.^5,P2.^6]);
hypothesis43=[ones(m,1),hypothesis43];
hypothesis43C=featureNormalizeLog([P1C,P2C,P2C.^2,P2C.^3,P2C.^4,P2C.^5,P2C.^6]);
hypothesis43C=[ones(m2,1),hypothesis43C];
theta43=zeros(size(hypothesis43,2),1);
hypothesis44=featureNormalizeLog([P1,P2,P2.^2,P2.^3,P2.^4,P2.^5,P2.^6,P2.^7,P2.^8]);
hypothesis44=[ones(m,1),hypothesis44];
hypothesis44C=featureNormalizeLog([P1C,P2C,P2C.^2,P2C.^3,P2C.^4,P2C.^5,P2C.^6,P2C.^7,P2C.^8]);
hypothesis4T=featureNormalizeLog([P1T,P2T,P2T.^2,P2T.^3,P2T.^4,P2T.^5,P2T.^6,P2T.^7,P2T.^8]);
hypothesis44C=[ones(m2,1),hypothesis44C];
hypothesis4T=[ones(m3,1),hypothesis4T];
theta44=zeros(size(hypothesis44,2),1);
initialCostH4=CostFunctionLogistic(hypothesis41,Y,theta41)
[thetaH41, J_historyH41]=GradientDescentLogistic(hypothesis41,Y,theta41,alphaH4,initialCostH1);
[thetaH42, J_historyH42]=GradientDescentLogistic(hypothesis42,Y,theta42,alphaH4,initialCostH1);
[thetaH43, J_historyH43]=GradientDescentLogistic(hypothesis43,Y,theta43,alphaH4,initialCostH1);
[thetaH44, J_historyH44]=GradientDescentLogistic(hypothesis44,Y,theta44,alphaH4,initialCostH1);
figure(7);
plot(1:length(J_historyH43), J_historyH43, '-b');
xlabel('Number of iterations');
ylabel('Cost J')
title('Hypothesis4');

finalCostH41=CostFunctionLogistic(hypothesis41C,YCV,thetaH41)
finalCostH42=CostFunctionLogistic(hypothesis42C,YCV,thetaH42)
finalCostH43=CostFunctionLogistic(hypothesis43C,YCV,thetaH43)
finalCostH44=CostFunctionLogistic(hypothesis44C,YCV,thetaH44)
figure(8);
plot(2:2:8,[finalCostH41,finalCostH42,finalCostH43,finalCostH44]);
xlabel('Polynomial degree');
ylabel('Error');
title('Hypothesis4');

%Chosen Degree 8
TestCostH41=CostFunctionLogistic(hypothesis4T,YTest,thetaH44)
%% TEST GRAPH 
figure(9);
stem(1:4,[TestCostH21,TestCostH11,TestCostH31,TestCostH41]);

xlabel('4 hypothesis');
ylabel('Error');
%% Clear temporary variables
clearvars filename delimiter startRow formatSpec fileID dataArray ans;
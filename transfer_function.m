% Ahmet Selim Canakci
%31/12/2020
%Transfer Function Creation Script
%Run this script before running simulink model. 

clear;
clc;
%Mercedes CLS 63 AMG Car Features
a = 1.45; % distance between front tires and the center of mass of the vehicle in meters
b=  1.41; % distance between rear tires and the center of mass of the vehicle in meters
total_length=  a+b;
total_mass = 2220; %kg 
m= total_mass;
Iz = 1549.034; %kg.m^2

% Predetermined Longitudunal and Vertical Speed of the Car
u_kmh = 50; %km/h
u0 = u_kmh /3.6; %m/s
%Calculation of the Car and Caf
Car = 6.048305201853278e+04;
Caf = 4.975910662517592e+04;


%state space model
Yb=-(Caf+Car); Yr=(Car*b/u0)-(Caf*a/u0); Yd= Caf;
Nb=b*Car-a*Caf; Nd= a*Caf;
Nr=-(a^2/u0)*Caf - (b^2/u0)*Car;
A=[0 1 u0 0;
0 Yb/m/u0 0 Yr/m-u0;
0 0 0 1;
0 Nb/Iz/u0 0 Nr/Iz];
B=[0;Yd/m;0;Nd/Iz];
C=[1 0 0 0]; D=0;
[num,Gvden]=ss2tf(A,B,C,D,1);
Gvnum=num(3:5);


%pade's approximate delay function for physical reaction(body movement
%time) = 0.2 Seconds
[exp_nump,exp_denp] = pade(0.2,3); %A 3rd order transfer function is produced





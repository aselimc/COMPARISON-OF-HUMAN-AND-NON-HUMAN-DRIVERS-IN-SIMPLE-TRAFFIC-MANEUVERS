% Ahmet Selim Canakci
%31/12/2020
%Graph Plot Script
%In order to work this script correctly, all four cases
%(non-human,human1,human2,human3)should be run in the Simulink model and
%run this script after each run of the Simulink model. Otherwise it won
%create necessary variables and won't show the graphs
close all;

c1 = circle(5.5,0.2,2.7);
c2 = circle(15.5,-0.,2.7);
x1 = c1(1,:);
y1 = c1(2,:);
x2 = c2(1,:);
y2 = c2(2,:);
road = out.road.Data;
y = out.y.Data;
time = out.tout;
type = out.Type.Data;
yl= [-1.2, 1.2];

if(type(1)==0)
    non_human = y;
    non_human_time = out.tout;
    non_human_error = out.error.Data;
    non_human_angle= out.Angle.Data;
elseif (type(1)==1)
    human_1 = y;
    human_1_time = out.tout;
    human_1_error = out.error.Data;
    human_1_angle = out.Angle.Data;
elseif (type(1)==2)
    human_2 = y;
    human_2_time = out.tout;
    human_2_error = out.error.Data;
    human_2_angle = out.Angle.Data;
else
    human_3 = y;
    human_3_time = out.tout;
    human_3_error = out.error.Data;
    human_3_angle = out.Angle.Data;
end

%Road Path Graph
if(exist('non_human','var')&& exist('human_1','var')&& exist('human_2','var')&& exist('human_3','var'))
road_plot = figure();
p=plot(time,road,'r');
p.LineWidth = 2;
ylim(yl);
grid on;
xlabel("Time (seconds)");
ylabel("Lateral Road Position (meters)");
title("Desired Road Path")
legend("Desired Road Path");
end

%Road Path Graph
if(exist('non_human','var')&& exist('human_1','var')&& exist('human_2','var')&& exist('human_3','var'))
road_plot_real = figure();
img = imread('img.jpg');
image('CData',img,'XData',[0 25],'YData',[-1.5 1.5]);
hold on
p=plot(time,road,'r');
p.LineWidth = 12;
hold on
p2=plot(x1,y1);
p2.LineWidth=0.1;
fill(x1,y1,'k');
hold on
p3=plot(x2,y2);
p3.LineWidth=0.1;
fill(x2,y2,'k');
ylim(yl);
xlabel("Time (seconds)");
ylabel("Lateral Road Position (meters)");
title("S Type Manuever - 2 Vehicle Case")
legend("Desired Road Path","","Vehicle 1","","Vehicle 2");
end

if(exist('non_human','var')&& exist('human_1','var')&& exist('human_2','var')&& exist('human_3','var'))
    drivers= figure();
    r = plot(time,road);
    r.LineWidth = 3;
    hold on
    nh = plot(non_human_time,non_human);
    nh.LineWidth = 2;
    hold on
    h1 = plot(human_1_time,human_1);
    h1.LineWidth = 2;
    hold on
    h2 = plot(human_2_time,human_2);
    h2.LineWidth = 2;
    hold on
    h3 = plot(human_3_time,human_3);
    h3.LineWidth = 2;
    ylim(yl);
    xlabel("Time (seconds)");
    ylabel("Lateral Road Position (meters)");
    title("Followed Road Paths")
    grid on
    legend ("Road","Non Human"," Human-1" , "Human-2" , "Human-3");
end

if(exist('non_human','var')&& exist('human_1','var')&& exist('human_2','var')&& exist('human_3','var'))
    error= figure();
    nh = plot(non_human_time,non_human_error);
    nh.LineWidth = 2;
    hold on
    h1 = plot(human_1_time,human_1_error);
    h1.LineWidth = 2;
    hold on
    h2 = plot(human_2_time,human_2_error);
    h2.LineWidth = 2;
    hold on
    h3 = plot(human_3_time,human_3_error);
    h3.LineWidth = 2;
    ylim([-0.5 0.5]);
    xlabel("Time (seconds)");
    ylabel("Deviation from Desired Path (meters)");
    title("Error Amount for the Drivers")
    grid on
    legend ("Non Human"," Human-1" , "Human-2" , "Human-3");
    
    
    angle= figure();
    nh = plot(non_human_time,non_human_angle);
    nh.LineWidth = 2;
    hold on
    h1 = plot(human_1_time,human_1_angle);
    h1.LineWidth = 2;
    hold on
    h2 = plot(human_2_time,human_2_angle);
    h2.LineWidth = 2;
    hold on
    h3 = plot(human_3_time,human_3_angle);
    h3.LineWidth = 2;
    ylim([-0.5 0.5]);
    xlabel("Time (seconds)");
    ylabel("Steering Angles (rad)");
    title("Steering Angles in the Maneuver")
    grid on
    legend ("Non Human"," Human-1" , "Human-2" , "Human-3");
    
    
    
total_non_human_e= sum(abs(non_human_error));
total_human_1_e = sum(abs(human_1_error));
total_human_2_e = sum(abs(human_2_error));
total_human_3_e = sum(abs(human_3_error));

end
try
saveas(road_plot,"road.png");
saveas(road_plot_real,"road2.png");
saveas(drivers,"drivers.png");
saveas(error,"error.png");
saveas(angle,"angle.png");

disp("Total Error of Non-human Controller "+total_non_human_e+"m");
disp("Total Error of Human-1 "+total_human_1_e+"m");
disp("Total Error of Human-2 "+total_human_2_e+"m");
disp("Total Error of Human-3 "+total_human_3_e+"m");
catch
end

function c = circle(x,y,r)
th = 0:pi/50:2*pi;
x_circle = r * cos(th) + x;
y_circle = 0.15*r * sin(th) + y;
c = [x_circle;y_circle];
end


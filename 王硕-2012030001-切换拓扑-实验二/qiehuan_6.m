global L
A1=[0 0 0 1 0 0
    0 0 0 0 0 0
    0 1 0 0 1 0
    0 1 0 0 1 0
    1 0 0 0 0 1
    0 0 1 0 0 0];
A2=[0 0 0 1 0 0
    1 0 0 0 0 0
    0 1 0 0 0 0
    0 0 0 0 1 0
    0 0 1 0 0 1
    0 1 0 0 0 0];
A3=[0 0 0 0 1 0
    1 0 0 0 0 1
    0 1 0 0 0 0
    0 1 0 0 0 0
    0 0 1 1 0 0
    0 0 0 0 1 0];
A4=[0 0 0 1 0 0
    1 0 0 0 0 0
    0 1 0 0 0 0
    0 0 0 0 1 0
    0 0 0 0 0 1
    0 0 1 0 0 0];
A5=[0 0 0 1 0 0
    1 0 0 0 0 1
    0 0 0 0 1 0
    0 1 0 0 0 0
    1 0 0 0 0 1
    0 0 1 0 0 0];
A6=[0 0 0 0 0 0
    1 0 0 0 0 1
    0 1 0 0 1 0
    0 1 0 0 0 0
    1 0 0 1 0 0
    0 0 1 0 0 0];

La= lapulasi(A1);
Lb= lapulasi(A2);
Lc= lapulasi(A3);
Ld= lapulasi(A4);
Le= lapulasi(A5);
Lf= lapulasi(A6);
%% Initial States
x_1(:,1) = 20; 
x_2(:,1) = 10; 
x_3(:,1) = 40; 
x_4(:,1) = 00; 
x_5(:,1) = 30; 
x_6(:,1) = 50; 
 
%% Time parameters
tBegin = 0;
tFinal = 6;
dT = 0.06;
times = (tFinal-tBegin)/dT;
t(1,1) = 0;
%% Iteration Calculate
for i=1:times
    % record time
    t(:,i+1) = t(:,i) + dT;
    
    % switch topology
    if mod(t(:,i),3) >= 0.0 && mod(t(:,i),3) < 0.5
        L = La;
    end
    if mod(t(:,i),3) >= 0.5 && mod(t(:,i),3) < 1.0
        L = Lb;
    end
    if mod(t(:,i),3) >= 1.0 && mod(t(:,i),3) < 1.5
        L = Lc;
    end
    if mod(t(:,i),3) >= 1.5 && mod(t(:,i),3) < 2.0
        L = Ld;
    end
    if mod(t(:,i),3) >= 2 && mod(t(:,i),3) < 2.5
        L = Le;
    end
    if mod(t(:,i),3) >= 2.5 && mod(t(:,i),3) < 3.0
        L = Lf;
    end
 % calculate control inputs
    u_1 = -L(1,1)*(x_1(i,:)-x_1(i,:)) - L(1,2)*(x_2(i,:)-x_1(i,:)) - L(1,3)*(x_3(i,:)-x_1(i,:)) - L(1,4)*(x_4(i,:)-x_1(i,:))- L(1,5)*(x_5(i,:)-x_1(i,:)) - L(1,6)*(x_6(i,:)-x_1(i,:));
    u_2 = -L(2,1)*(x_1(i,:)-x_2(i,:)) - L(2,2)*(x_2(i,:)-x_2(i,:)) - L(2,3)*(x_3(i,:)-x_2(i,:)) - L(2,4)*(x_4(i,:)-x_2(i,:))- L(2,5)*(x_5(i,:)-x_2(i,:)) - L(2,6)*(x_6(i,:)-x_2(i,:));
    u_3 = -L(3,1)*(x_1(i,:)-x_3(i,:)) - L(3,2)*(x_2(i,:)-x_3(i,:)) - L(3,3)*(x_3(i,:)-x_3(i,:)) - L(3,4)*(x_4(i,:)-x_3(i,:))- L(3,5)*(x_5(i,:)-x_3(i,:)) - L(3,6)*(x_6(i,:)-x_3(i,:));
    u_4 = -L(4,1)*(x_1(i,:)-x_4(i,:)) - L(4,2)*(x_2(i,:)-x_4(i,:)) - L(4,3)*(x_3(i,:)-x_4(i,:)) - L(4,4)*(x_4(i,:)-x_4(i,:))- L(4,5)*(x_5(i,:)-x_4(i,:)) - L(4,6)*(x_6(i,:)-x_4(i,:));
    u_5 = -L(5,1)*(x_1(i,:)-x_5(i,:)) - L(5,2)*(x_2(i,:)-x_5(i,:)) - L(5,3)*(x_3(i,:)-x_5(i,:)) - L(5,4)*(x_4(i,:)-x_5(i,:))- L(5,5)*(x_5(i,:)-x_5(i,:)) - L(5,6)*(x_6(i,:)-x_5(i,:));
    u_6 = -L(6,1)*(x_1(i,:)-x_6(i,:)) - L(6,2)*(x_2(i,:)-x_6(i,:)) - L(6,3)*(x_3(i,:)-x_6(i,:)) - L(6,4)*(x_4(i,:)-x_6(i,:))- L(6,5)*(x_5(i,:)-x_6(i,:)) - L(6,6)*(x_6(i,:)-x_6(i,:));
    
% update statues
    x_1(i+1,1) = x_1(i,1) + dT*u_1;
    x_2(i+1,1) = x_2(i,1) + dT*u_2;
    x_3(i+1,1) = x_3(i,1) + dT*u_3;
    x_4(i+1,1) = x_4(i,1) + dT*u_4;
    x_5(i+1,1) = x_5(i,1) + dT*u_5;
    x_6(i+1,1) = x_6(i,1) + dT*u_6;
end
%% Draw graphs
figure()
plot(t,x_1, '-',  'linewidth',1.5); hold on;
plot(t,x_2, '--', 'linewidth',1.5);
plot(t,x_3, '-.', 'linewidth',1.5);
plot(t,x_4, ':',  'linewidth',1.5);
plot(t,x_5, '-.', 'linewidth',1.5);
plot(t,x_6, ':',  'linewidth',1.5);
grid on;
xlabel('$t$ (s)','Interpreter','latex', 'FontSize',16);
ylabel('$x_i$','Interpreter','latex', 'FontSize',16);
legend('$x_1$','$x_2$','$x_3$','$x_4$','$x_5$','$x_6$','Interpreter','latex', 'FontSize',14);

function out =  lapulasi(A)
    A_transpose = transpose(A); 
    D = diag(sum(A_transpose)); 
    out = D - A;
end
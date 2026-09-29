clear
clc

%Poblacion
N=1000;
%Cantidad de infromacion genetica de cada individuo
D=2; 
%Posibilidad de mutar de los hijos
Pm=0;
%Numeo de genraciones
generaciones=5;

%% Funcion a plotear con axis 
% 
f=@(x,y)((x-2).^2)+((y-2).^2);
[xfuncion,yfuncion]=meshgrid(-20:.5:20,-10:.5:20);
z=((xfuncion-2).^2)+((yfuncion-2).^2);
axis([-20 20 -10 20])
% 
% f=@(x,y) x.*exp(-x.^2-y.^2);
% [xfuncion,yfuncion]=meshgrid(-20:.1:20,-10:.1:20);
% z=xfuncion.*exp(-xfuncion.^2-yfuncion.^2);
% axis([-4 4 -4 4])
hold on

%Inizializar variables
x=zeros(D,N);
aptitud=zeros(1,N);


%Limites
xi=[-5;-5];
xu=[5;5];



%%
%Inizializar a la poblacion de N miembros
for i=1:N
    x(:,i)=xi+(xu-xi).*rand(D,1);
end

%%
xh=zeros(size(x));
for s=1:generaciones

%Evaluar que tan chingon es cada individuo
for i=1:N
    aux1=x(1,i);
    aux2=x(2,i);
    fx=f(aux1,aux2);
    if fx>=0
        aptitud(i)=(1/(1+fx));
    end
    if fx<0
        aptitud(i)=(1+abs(fx));
    end
end
for j=1:2:N
    %% Mejor candidato
    ind1=Ruleta(aptitud,N);
    ind2=Ruleta(aptitud,N);
    while ind1==ind2
        ind2=Ruleta(aptitud,N);
    end
    xp1=x(:,ind1);
    xp2=x(:,ind2);
    %% SEXO
    pc=randi([1,D]);
    xh1=[xp1(1:pc); xp2(pc+1:end)];
    xh2=[xp2(1:pc); xp1(pc+1:end)];
    xh(:,j)=xh1;
    xh(:,j+1)=xh2;
end
%%Mutar a la generacion nueva
for w=1:N
    for k=1:D
        if randi([0 1])<Pm   %Pm= probabilidad de mutar
            xh(k,w)=xi(k)+(xu(k)-xi(k))*rand();
        else
        end
        
    end
    
end
%%
%Plotear cada individuo de cada generacion
cla;
surfc(xfuncion,yfuncion,z);%Original

for q=1:N
plot3(x(1,q),x(2,q),f(x(1,q),x(2,q)),'ro');
end
axis([-5 5 -5 5]);
pause(.01);
%% CAMBIAR HIJOS POR PADRES
x=xh;
end

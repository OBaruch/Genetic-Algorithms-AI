function indp=Ruleta(aptitud,N)
suma_aptitud=0;
for i=1:N
    suma_aptitud=suma_aptitud+aptitud(i);
end
P=zeros(1,N);
for i=1:N
    P(i)=(aptitud(i)/suma_aptitud);
end
r=rand();
Psum=0;
for i=1:N
    Psum=Psum+P(i);
    if Psum>=r
        indp=i;
        return;
    end
end
indp=N;
end
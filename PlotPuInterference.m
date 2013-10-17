%Plot PU Interference
clear;
pa=parameter;
RunTimes=pa.RunTimes;
SUProtectRange=pa.SUProtectRange;
SpoofRange=pa.SpoofRange;%Spoofing capability


SUNumber=100;
filename=['Result_SUNUmber_',num2str(SUNumber),'_SUProtectRange_',num2str(SUProtectRange),'_SpoofRange_',num2str(SpoofRange)];
tmp=load(filename);
InterferePU=tmp.InterferePU;
minPU=min(InterferePU);
maxPU=max(InterferePU);
PlotPU=zeros(1,maxPU-minPU+1);
PUIndex=1;
for i=minPU:maxPU
    PlotPU(1,PUIndex)=sum(ismember(InterferePU,i));
    PUIndex=PUIndex+1;
end
PlotPU=PlotPU/RunTimes;
figure(1)
plot(minPU:maxPU,PlotPU,'red');
hold on;
grid on;

SUNumber=200;
filename=['Result_SUNUmber_',num2str(SUNumber),'_SUProtectRange_',num2str(SUProtectRange),'_SpoofRange_',num2str(SpoofRange)];
tmp=load(filename);
InterferePU=tmp.InterferePU;
minPU=min(InterferePU);
maxPU=max(InterferePU);
PlotPU=zeros(1,maxPU-minPU+1);
PUIndex=1;
for i=minPU:maxPU
    PlotPU(1,PUIndex)=sum(ismember(InterferePU,i));
    PUIndex=PUIndex+1;
end
PlotPU=PlotPU/RunTimes;
plot(minPU:maxPU,PlotPU,'yellow');
hold on;

SUNumber=300;
filename=['Result_SUNUmber_',num2str(SUNumber),'_SUProtectRange_',num2str(SUProtectRange),'_SpoofRange_',num2str(SpoofRange)];
tmp=load(filename);
InterferePU=tmp.InterferePU;
minPU=min(InterferePU);
maxPU=max(InterferePU);
PlotPU=zeros(1,maxPU-minPU+1);
PUIndex=1;
for i=minPU:maxPU
    PlotPU(1,PUIndex)=sum(ismember(InterferePU,i));
    PUIndex=PUIndex+1;
end
PlotPU=PlotPU/RunTimes;
plot(minPU:maxPU,PlotPU,'blue');
hold on;
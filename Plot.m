%Plot Spoofing Attack Impact CDF 
clear;
pa=parameter;
RunTimes=pa.RunTimes;
SUNumber=pa.SUNumber;%Number of SUs
SUProtectRange=pa.SUProtectRange;
SpoofRange=pa.SpoofRange;%Spoofing capability
filename=['Result_SUNUmber_',num2str(SUNumber),'_SUProtectRange_',num2str(SUProtectRange),'_SpoofRange_',num2str(SpoofRange)];
tmp=load(filename);
InterferePU=tmp.InterferePU;
FalseChannelRunOut=tmp.FalseChannelRunOut;
% [f1,x1]=hist(InterferePU,max(InterferePU)-min(InterferePU)+1);
% [f2,x2]=hist(FalseChannelRunOut,max(FalseChannelRunOut)-min(FalseChannelRunOut)+1);
% figure(1)
% bar(x1,f1/trapz(x1,f1));
% grid on;
% figure(2)
% bar(x2,f2/trapz(x2,f2));
% grid on;
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
plot(minPU:maxPU,PlotPU);
grid on;
minFalseRunOut=min(FalseChannelRunOut);
maxFalseRunOut=max(FalseChannelRunOut);
PlotFalseRunOut=zeros(1,maxFalseRunOut-minFalseRunOut+1);
FalseRunOutIndex=1;
for i=minFalseRunOut:maxFalseRunOut
    PlotFalseRunOut(1,FalseRunOutIndex)=sum(ismember(FalseChannelRunOut,i));
    FalseRunOutIndex=FalseRunOutIndex+1;
end
PlotFalseRunOut=PlotFalseRunOut/RunTimes;
figure(2)
plot(minFalseRunOut:maxFalseRunOut,PlotFalseRunOut);
grid on;

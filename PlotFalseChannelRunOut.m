%plot False Channel Runnout
clear;
pa=parameter;
RunTimes=pa.RunTimes;
SUProtectRange=pa.SUProtectRange;
SpoofRange=pa.SpoofRange;%Spoofing capability

SUNumber=100;
filename=['Result_SUNUmber_',num2str(SUNumber),'_SUProtectRange_',num2str(SUProtectRange),'_SpoofRange_',num2str(SpoofRange)];
tmp=load(filename);
FalseChannelRunOut=tmp.FalseChannelRunOut;
minFalseRunOut=min(FalseChannelRunOut);
maxFalseRunOut=max(FalseChannelRunOut);
PlotFalseRunOut=zeros(1,maxFalseRunOut-minFalseRunOut+1);
FalseRunOutIndex=1;
for i=minFalseRunOut:maxFalseRunOut
    PlotFalseRunOut(1,FalseRunOutIndex)=sum(ismember(FalseChannelRunOut,i));
    FalseRunOutIndex=FalseRunOutIndex+1;
end
PlotFalseRunOut=PlotFalseRunOut/RunTimes;
figure(1)
plot(minFalseRunOut:maxFalseRunOut,PlotFalseRunOut,'red');
hold on;
grid on;

SUNumber=200;
filename=['Result_SUNUmber_',num2str(SUNumber),'_SUProtectRange_',num2str(SUProtectRange),'_SpoofRange_',num2str(SpoofRange)];
tmp=load(filename);
FalseChannelRunOut=tmp.FalseChannelRunOut;
minFalseRunOut=min(FalseChannelRunOut);
maxFalseRunOut=max(FalseChannelRunOut);
PlotFalseRunOut=zeros(1,maxFalseRunOut-minFalseRunOut+1);
FalseRunOutIndex=1;
for i=minFalseRunOut:maxFalseRunOut
    PlotFalseRunOut(1,FalseRunOutIndex)=sum(ismember(FalseChannelRunOut,i));
    FalseRunOutIndex=FalseRunOutIndex+1;
end
PlotFalseRunOut=PlotFalseRunOut/RunTimes;
plot(minFalseRunOut:maxFalseRunOut,PlotFalseRunOut,'yellow');
hold on;


SUNumber=300;
filename=['Result_SUNUmber_',num2str(SUNumber),'_SUProtectRange_',num2str(SUProtectRange),'_SpoofRange_',num2str(SpoofRange)];
tmp=load(filename);
FalseChannelRunOut=tmp.FalseChannelRunOut;
minFalseRunOut=min(FalseChannelRunOut);
maxFalseRunOut=max(FalseChannelRunOut);
PlotFalseRunOut=zeros(1,maxFalseRunOut-minFalseRunOut+1);
FalseRunOutIndex=1;
for i=minFalseRunOut:maxFalseRunOut
    PlotFalseRunOut(1,FalseRunOutIndex)=sum(ismember(FalseChannelRunOut,i));
    FalseRunOutIndex=FalseRunOutIndex+1;
end
PlotFalseRunOut=PlotFalseRunOut/RunTimes;
plot(minFalseRunOut:maxFalseRunOut,PlotFalseRunOut,'blue');
hold on;
%Plot Normal Channel Run Out
%plot  Channel Runnout
clear;
pa=parameter;
RunTimes=pa.RunTimes;
SUProtectRange=pa.SUProtectRange;
SpoofRange=pa.SpoofRange;%Spoofing capability

SUNumber=100;
filename=['Result_SUNUmber_',num2str(SUNumber),'_SUProtectRange_',num2str(SUProtectRange),'_SpoofRange_',num2str(SpoofRange)];
tmp=load(filename);
ChannelRunOut=tmp.ChannelRunOut;
minChannelRunOut=min(ChannelRunOut);
maxChannelRunOut=max(ChannelRunOut);
PlotChannelRunOut=zeros(1,maxChannelRunOut-minChannelRunOut+1);
ChannelRunOutIndex=1;
for i=minChannelRunOut:maxChannelRunOut
    PlotChannelRunOut(1,ChannelRunOutIndex)=sum(ismember(ChannelRunOut,i));
    ChannelRunOutIndex=ChannelRunOutIndex+1;
end
PlotChannelRunOut=PlotChannelRunOut/RunTimes;
figure(1)
plot(minChannelRunOut:maxChannelRunOut,PlotChannelRunOut,'red');
hold on;
grid on;

SUNumber=200;
filename=['Result_SUNUmber_',num2str(SUNumber),'_SUProtectRange_',num2str(SUProtectRange),'_SpoofRange_',num2str(SpoofRange)];
tmp=load(filename);
ChannelRunOut=tmp.ChannelRunOut;
minChannelRunOut=min(ChannelRunOut);
maxChannelRunOut=max(ChannelRunOut);
PlotChannelRunOut=zeros(1,maxChannelRunOut-minChannelRunOut+1);
ChannelRunOutIndex=1;
for i=minChannelRunOut:maxChannelRunOut
    PlotChannelRunOut(1,ChannelRunOutIndex)=sum(ismember(ChannelRunOut,i));
    ChannelRunOutIndex=ChannelRunOutIndex+1;
end
PlotChannelRunOut=PlotChannelRunOut/RunTimes;
plot(minChannelRunOut:maxChannelRunOut,PlotChannelRunOut,'yellow');
hold on;


SUNumber=300;
filename=['Result_SUNUmber_',num2str(SUNumber),'_SUProtectRange_',num2str(SUProtectRange),'_SpoofRange_',num2str(SpoofRange)];
tmp=load(filename);
ChannelRunOut=tmp.ChannelRunOut;
minChannelRunOut=min(ChannelRunOut);
maxChannelRunOut=max(ChannelRunOut);
PlotChannelRunOut=zeros(1,maxChannelRunOut-minChannelRunOut+1);
ChannelRunOutIndex=1;
for i=minChannelRunOut:maxChannelRunOut
    PlotChannelRunOut(1,ChannelRunOutIndex)=sum(ismember(ChannelRunOut,i));
    ChannelRunOutIndex=ChannelRunOutIndex+1;
end
PlotChannelRunOut=PlotChannelRunOut/RunTimes;
plot(minChannelRunOut:maxChannelRunOut,PlotChannelRunOut,'blue');
hold on;
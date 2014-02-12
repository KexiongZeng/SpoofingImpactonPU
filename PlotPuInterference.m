%Plot PU Interference
clear;
close all;
pa=parameter;
RunTimes=pa.RunTimes;
SUProtectRange=pa.SUProtectRange;
SpoofRange=pa.SpoofRange;%Spoofing capability
Result=zeros(1,10);

% SUNumber=100;
% filename=['Result_SUNUmber_',num2str(SUNumber),'_SUProtectRange_',num2str(SUProtectRange),'_SpoofRange_',num2str(SpoofRange)];
% tmp=load(filename);
% InterferePU=tmp.InterferePU;
% % minPU=min(InterferePU);
% % maxPU=max(InterferePU);
% % PlotPU=zeros(1,maxPU-minPU+1);
% % PUIndex=1;
% % for i=minPU:maxPU
% %     PlotPU(1,PUIndex)=sum(ismember(InterferePU,i));
% %     PUIndex=PUIndex+1;
% % end
% % PlotPU=PlotPU/RunTimes;
% figure(1)
% %plot(minPU:maxPU,PlotPU,'red');
% [f,x]=ecdf(InterferePU);
% plot(x,f,'red');
% hold on;
% grid on;

% SUNumber=400;
% filename=['Result_SUNUmber_',num2str(SUNumber),'_SUProtectRange_',num2str(SUProtectRange),'_SpoofRange_',num2str(SpoofRange)];
% tmp=load(filename);
% InterferePU=tmp.InterferePU;
% % minPU=min(InterferePU);
% % maxPU=max(InterferePU);
% % PlotPU=zeros(1,maxPU-minPU+1);
% % PUIndex=1;
% % for i=minPU:maxPU
% %     PlotPU(1,PUIndex)=sum(ismember(InterferePU,i));
% %     PUIndex=PUIndex+1;
% % end
% % PlotPU=PlotPU/RunTimes;
% % plot(minPU:maxPU,PlotPU,'yellow');
% InterfereSUNumber=sum(InterferePU,2);
% [f,x]=ecdf(InterfereSUNumber);
% plot(x,f,'yellow');
% hold on;
for i=4:10
 SUNumber=100*i;
filename=['Result_SUNUmber_',num2str(SUNumber),'_SUProtectRange_',num2str(SUProtectRange),'_SpoofRange_',num2str(SpoofRange)];
tmp=load(filename);
InterferePU=tmp.InterferePU;
InterfereSUNumber=sum(InterferePU,2); 
worstcase=max(InterfereSUNumber);
Result(i)=worstcase;
end

plot(1:7,smooth(Result(4:10),5,'moving'));
% [f,x]=ecdf(InterfereSUNumber);
% %plot(x,f,'red');
% plot(x,smooth(f,5,'moving'),'blue');
% hold on;
% 
% % SUNumber=600;
% % filename=['Result_SUNUmber_',num2str(SUNumber),'_SUProtectRange_',num2str(SUProtectRange),'_SpoofRange_',num2str(SpoofRange)];
% % tmp=load(filename);
% % InterferePU=tmp.InterferePU;
% % InterfereSUNumber=sum(InterferePU,2);
% % [f,x]=ecdf(InterfereSUNumber);
% % plot(x,f,'red');
% % hold on;
% 
% SUNumber=500;
% filename=['Result_SUNUmber_',num2str(SUNumber),'_SUProtectRange_',num2str(SUProtectRange),'_SpoofRange_',num2str(SpoofRange)];
% tmp=load(filename);
% InterferePU=tmp.InterferePU;
% InterfereSUNumber=sum(InterferePU,2);
% [f,x]=ecdf(InterfereSUNumber);
% plot(x,f,'black');
% hold on;
% % 
% % SUNumber=800;
% % filename=['Result_SUNUmber_',num2str(SUNumber),'_SUProtectRange_',num2str(SUProtectRange),'_SpoofRange_',num2str(SpoofRange)];
% % tmp=load(filename);
% % InterferePU=tmp.InterferePU;
% % InterfereSUNumber=sum(InterferePU,2);
% % [f,x]=ecdf(InterfereSUNumber);
% % plot(x,f,'green');
% % hold on;
% 
% SUNumber=600;
% filename=['Result_SUNUmber_',num2str(SUNumber),'_SUProtectRange_',num2str(SUProtectRange),'_SpoofRange_',num2str(SpoofRange)];
% tmp=load(filename);
% InterferePU=tmp.InterferePU;
% InterfereSUNumber=sum(InterferePU,2);
% [f,x]=ecdf(InterfereSUNumber);
% plot(x,f,'m');
% hold on;
% SUNumber=2500;
% filename=['Result_SUNUmber_',num2str(SUNumber),'_SUProtectRange_',num2str(SUProtectRange),'_SpoofRange_',num2str(SpoofRange)];
% tmp=load(filename);
% InterferePU=tmp.InterferePU;
% InterfereSUNumber=sum(InterferePU,2);
% [f,x]=ecdf(InterfereSUNumber);
% plot(x,f,'magenta');
% hold on;
% grid on;
% legend;
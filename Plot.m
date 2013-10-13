%Plot Spoofing Attack Impact CDF 
pa=parameter;
SUNumber=pa.SUNumber;%Number of SUs
SUProtectRange=pa.SUProtectRange;
SpoofRange=pa.SpoofRange;%Spoofing capability
filename=['Result_SUNUmber_',num2str(SUNumber),'_SUProtectRange_',num2str(SUProtectRange),'_SpoofRange_',num2str(SpoofRange)];
tmp=load(filename);
InterferePU=tmp.InterferePU;
FalseChannelRunOut=tmp.FalseChannelRunOut;
[f1,x1]=hist(InterferePU,max(InterferePU)-min(InterferePU)+1);
[f2,x2]=hist(FalseChannelRunOut,max(FalseChannelRunOut)-min(FalseChannelRunOut)+1);
figure(1)
bar(x1,f1/trapz(x1,f1));
grid on;
figure(2)
bar(x2,f2/trapz(x2,f2));
grid on;
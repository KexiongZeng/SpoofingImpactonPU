a=ChannelInterferedDistribution_RandomAttack;
b=sum(a);
c=sum(b);
d=b/c;
x=1:51;
figure(1)
bar(x,d);
channel=[  7     9    12    21    22    27    29    33    34    35    38    39    47    48    50    51];
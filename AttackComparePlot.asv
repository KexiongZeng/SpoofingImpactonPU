a=ChannelInterfered_RandomAttack;
b=ChannelInterfered_GreedyAttack;
c=ChannelInterfered_OptimalAttack;
a=[a,ChannelInterfered_RandomAttack];
b=[b,ChannelInterfered_GreedyAttack];
c=[c,ChannelInterfered_OptimalAttack];
ChannelInterfered_RandomAttack=a;
ChannelInterfered_GreedyAttack=b;
ChannelInterfered_OptimalAttack=c;
save('tmp','ChannelInterfered_RandomAttack','ChannelInterfered_GreedyAttack','ChannelInterfered_OptimalAttack');
mean(ChannelInterfered_RandomAttack)
mean(ChannelInterfered_GreedyAttack)
mean(ChannelInterfered_OptimalAttack)
plot(ChannelInterfered_RandomAttack,'blue');
hold on;
plot(ChannelInterfered_GreedyAttack,'red');
hold on;
plot(ChannelInterfered_OptimalAttack,'black');
[f,x]=ecdf(ChannelInterfered_RandomAttack);
plot(x,f,'blue');
hold on;
[f,x]=ecdf(ChannelInterfered_GreedyAttack);
plot(x,f,'red');
hold on;
[f,x]=ecdf(ChannelInterfered_OptimalAttack);
plot(x,f,'green');


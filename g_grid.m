format long;
R =33000; %radius of outer circle, changeable 30:30:1500 meter
R0 = 0; %radius of inner circle
M = 12; %%%% number of malicious users
xCoordinates = [];
yCoordinates = [];
n = M;
while n > 0
x = unifrnd(0,R,1,1);
y = unifrnd(0,R,1,1);
norms = sqrt(((x).^2) + ((y).^2));
inBounds = find((R0 <= norms) & (norms <= R));
xCoordinates = [xCoordinates; x(inBounds)];
yCoordinates = [yCoordinates; y(inBounds)];
n = M - numel(xCoordinates);
end
a=size(n,2);
a=[xCoordinates yCoordinates];
scatter(a(:,1),a(:,2));

Spectrum_grid = zeros(330,330);
a_normalized = a./100;
a_norm_rounded = round(a_normalized);


for i=1:M
    Spectrum_grid(a_norm_rounded(i,1),a_norm_rounded(i,2))= Spectrum_grid(a_norm_rounded(i,1),a_norm_rounded(i,2))+1;
    a_norm_rounded(i,1)
    a_norm_rounded(i,2)
end

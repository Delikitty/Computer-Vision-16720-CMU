function [NormalizedP,T]=DLTnormalization(p)
% input p is a 2*N matrix which 1st row is x coordinate and 2nd is y

N = size(p,2);
originpoint = [(sum(p(1,:))./N);(sum(p(2,:)./N))];
PO = p-originpoint*ones(1,N);
% centroid of the points is the coordinate origin

dissquare = PO.^2;
dis = zeros(1,N);
for i = 1:N
    dis(i) = sqrt(dissquare(1,i)+dissquare(2,i));
end

dismean = sum(dis)./N;
s = sqrt(2)./dismean;
% make their average distance from the origin is sqrt(2)
NormalizedP = PO*s;
% normalized coordinates 
T = [s 0 -s*originpoint(1);0 s -s*originpoint(2);0 0 1];
% the transform T that take points to a new normalized coordinate
end
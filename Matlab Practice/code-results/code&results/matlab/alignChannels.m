function [rgbResult] = alignChannels(red, green, blue)

Red=red.red;
Green=green.green;
Blue=blue.blue;

[row,col]=size(Red);

gssd=zeros(61,61);
bssd=zeros(61,61);
for x=-30:30;
    for y=-30:30;
        gshift=circshift(Green,[x y]);
        bshift=circshift(Blue,[x y]);
        if x>=0
            gshift(1:x,:)=0;
            bshift(1:x,:)=0;
        else
            gshift((row+x+1):row,:)=0;
            bshift((row+x+1):row,:)=0;
        end
        if y>=0
            gshift(:,1:y)=0;
            bshift(:,1:y)=0;
        else
            gshift(:,(col+y+1):col)=0;
            bshift(:,(col+y+1):col)=0;
        end
        
        gssd(x+31,y+31)=sum(sum(gshift-Red).^2);
        bssd(x+31,y+31)=sum(sum(bshift-Red).^2);
        
        end
end

mingssd=min(min(gssd));
fg=find(gssd>=mingssd & gssd<=mingssd);
minbssd=min(min(bssd));
fb=find(bssd>=minbssd & bssd<=minbssd);

[ga,gb]=ind2sub([61 61],fg);ga=ga-31;gb=gb-31;
[ba,bb]=ind2sub([61 61],fb);ba=ba-31;bb=bb-31;

GREEN=circshift(Green,[ga gb]);
BLUE=circshift(Blue,[ba bb]);
if ga>=0;
    GREEN(1:ga,:)=0;
else
    GREEN((row+ga+1):row,:)=0;
end
if gb>=0;
    GREEN(:,1:gb)=0;
else
    GREEN(:,(col+gb+1):col)=0;
end

if ba>=0;
    BLUE(1:ba,:)=0;
else
    BLUE((row+ba+1):row,:)=0;
end
if bb>=0;
    BLUE(:,1:bb)=0;
else
    BLUE(:,(col+bb+1):col)=0;
end


rgbResult=cat(3,Red,GREEN,BLUE);
imshow(rgbResult);
end


function [ warp_im ] = warpA( im_gray, A, out_size )
[x y]=meshgrid(1:out_size(2),1:out_size(1));
invA=inv(A);
[row col]=size(im_gray);
cor_warp=[x(:),y(:),ones(row*col,1)]';
cor_s=(invA*cor_warp);
px=cor_s(1,:);px=round(px);
py=cor_s(2,:);py=round(py);
pxp=px>0 & px<=150;
pyp=py>0 & py<=200;
p=pxp.*pyp;
sx=px.*p;
sy=py.*p;
k=find(p>0);
xk=sx(k);
yk=sy(k);
ind=sub2ind(size(im_gray),yk,xk);
inten=im_gray(ind);
warp_im=zeros(row,col);
wx=[x(:)]';
wy=[y(:)]';
wxk=wx(k);
wyk=wy(k);
indw=sub2ind(size(warp_im),wyk,wxk);
warp_im(indw)=inten;



function [filterResponses] = extractFilterResponses(img, filterBank)
% Extract filter responses for the given image.
% Inputs: 
% Input_img:a 3-channel RGB image with width W and height H
img=im2double(img);
%switch to floating point type
if size(img,3)==3
     [L,a,b]=RGB2Lab(img(:,:,1),img(:,:,2),img(:,:,3));
end

if size(img,3)==1
     img=repmat(img,1,1,3);
     [L,a,b]=RGB2Lab(img(:,:,1),img(:,:,2),img(:,:,3));
end
% convert image into lab space
%% set up parametres and empty matrix
h=size(img,1);
w=size(img,2);
F=length(filterBank);
[filterBank] = createFilterBank();
filterResponses=zeros(h,w,3*F);
%% get filtered responses for each channel in each filter 
for i=1:F
    filterResponses(:,:,3*i-2)=imfilter(L,filterBank{i},'symmetric','same','conv');
    filterResponses(:,:,3*i-1)=imfilter(a,filterBank{i},'symmetric','same','conv');
    filterResponses(:,:,3*i)=imfilter(b,filterBank{i},'symmetric','same','conv');
end

%I=reshape(filterResponses,h,w,3,20);
%output=montage(I,'Size',[4 5]);

%% Below is part of the first version which I output a 2-dim matrix
% Just keep it for reference

% get reshaped matrices of different channels
%imcell=cell(3,20);

%for j=1:20
%    imcell{1,j}=reshape(filterresponses(:,3*j-2),[h,w]);
%    imcell{2,j}=reshape(filterresponses(:,3*j-1),[h,w]);
%    imcell{3,j}=reshape(filterresponses(:,3*j),[h,w]);
%end

% matrix I used for func montage
%I=zeros(h,w,3,20);
%for num=1:20
%    I(:,:,:,num)=cat(3,imcell{1,num},imcell{2,num},imcell{3,num});
%end

% get 3-dim output filter response
%filterResponses=reshape(I,h,w,60);

% TODO Implement your code here

end

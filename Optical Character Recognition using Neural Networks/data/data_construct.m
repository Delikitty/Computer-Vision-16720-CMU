load('nist26_train.mat')
train_data = train_data - repmat(mean(train_data,2),[1,size(train_data,2)]);
train_data = train_data ./ repmat(std(train_data,0,2),[1,size(train_data,2)]);

mkdir('nist_26')
for i=1:26
    dirname = sprintf('nist_26/%d',i)
    mkdir(dirname)    
end

[~,label_idx] = max(train_labels,[],2);
for i = 1:size(train_data,1)
    img = reshape(train_data(i,:),32,32);
    filename = sprintf('%d.jpg',i);
    filename_whole = ['nist_26/',num2str(label_idx(i)),'/',filename];
    imwrite(img, filename_whole)
    fprintf('%d\n',i)
    
end
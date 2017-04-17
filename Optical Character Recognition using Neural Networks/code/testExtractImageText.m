%% Load the trained paremeters W and b to calssify text in image

clear
close all
clc

cal = 1;
gtruth = cell(6,1);
correct = zeros(4,1);
gtruth{1} = 'TODOLIST1MAKEATODOLIST2CHECKOFFTHEFIRSTTHINGONTODOLIST3REALIZEYOUHAVEALREADYCOMPLETED2THINGS4REWARDYOURSELFWITHANAP';
gtruth{2} = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890';
gtruth{3} = 'HAIKUSAREEASYBUTSOMETIMESTHEYDONTMAKESENSEREFRIGERATOR';
gtruth{4} = 'DEEPLEARNINGDEEPERLEARNINGDEEPESTLEARNING';
% gtruth{5} = 'ILOVEMYCATSIMISSEDTHEMBAD';
% gtruth{6} = 'CITYOFSTARSJUSTONETHINGEVERYBODYWANT';

%% Get the file name

str='../images/';
file = dir(str);
file = struct2cell(file);
file = file(1,:);
Fname = cell(1);

for i=1:length(file)
    
    if strfind(file{i},'.jpg')
        Fname{cal} = [str,file{i}];
        cal = cal+1;
    end
    
end

n = length(Fname);
fprintf('There are %d images to be tested\n',n);
%% Display the extracted text in image
for j=1:n
     
    
    fprintf('--------------------------------------------------\n');
        if j==5
        fprintf('Image5 and image6 are test image I created\n');
        fprintf('--------------------------------------------------\n');
        end
    fprintf('Extracted Text from image %d\n\n',j);
    fname = Fname{j};
    [text] = extractImageText(fname);
    text = cell2mat(text);
    disp(text);
    % remove the space and enter in text for computing accuracy
    if j==1 || j==2 || j==3 || j==4
        flatten = regexprep(text,'[^\w'']','');
        correct_num = flatten==gtruth{j};
        testacr = sum(correct_num) ./ length(correct_num);
        correct(j) = sum(correct_num);
        fprintf('Accuracy for this test image is: %f\n' , testacr);
        fprintf('--------------------------------------------------\n');
    end
    
end

%% Compute overall accuracy
overallacr = sum(correct) ./ 246;
fprintf('Overall accuracy for 4 test images is: %f\n' , overallacr);
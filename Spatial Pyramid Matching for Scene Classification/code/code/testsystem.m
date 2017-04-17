delete dictionary.mat;
delete vision.mat
clc
clear
close all

tic

fprintf('compute dictionary')
computeDictionary();
fprintf('batchtovisualwords')
numCores = 2;
batchToVisualWords(numCores);
fprintf('buildrecognitionsystem')
buildRecognitionSystem();
fprintf('evaluaterecognitionsystem')
[conf] = evaluateRecognitionSystem();
fprintf('System accracy is %f',conf);

toc

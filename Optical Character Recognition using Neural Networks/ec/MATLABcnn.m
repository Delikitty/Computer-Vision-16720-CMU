clear
clc

%% Define layers
layers = [imageInputLayer([32 32 1],'Normalization','none')
          convolution2dLayer(5,20)
          reluLayer
          maxPooling2dLayer(2,'Stride',2)
          convolution2dLayer(5,40)
          reluLayer
          maxPooling2dLayer(2,'Stride',2)
          fullyConnectedLayer(26)
          softmaxLayer
          classificationLayer];
      
opts = trainingOptions('sgdm','MaxEpochs',10,'CheckpointPath','../code','OutputFcn',@plotTrainingAccuracy);
data = imageDatastore('../data/nist_26','IncludeSubfolders',1,'LabelSource','foldernames');
convnet = trainNetwork(data,layers,opts);

function plotTrainingAccuracy(info)

persistent plotObj

if info.State == "start"
    plotObj = animatedline;
    xlabel("Iteration")
    ylabel("Training Accuracy")
elseif info.State == "iteration"
    addpoints(plotObj,info.Iteration,info.TrainingAccuracy)
    drawnow limitrate nocallbacks
end

end
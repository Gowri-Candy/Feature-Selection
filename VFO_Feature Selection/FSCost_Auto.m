%
% Copyright (c) 2019 
% All rights reserved. Please read the "license.txt" for license terms.
%
% Developer : R.Gowri, Dr. R. Rathipriya
% Contact email - gowri.candy@gmail.com ,
% rathi_priyar@periyaruniversity.ac.in
% 
% thanks to yarpiz.com for its support

function [z, out]=FSCost_Auto(u,data)

    % Read Data Elements
    x=data.x;
    t=data.t;
    nx=data.nx;
    
    % converting the charge to feature id...
    q=mod(round(u),2);
    
    % Selected features
    S=find(q);
    
    % number of features selected
    nf=length(S);
%     if nx==nf           %if all the features are taken
%         r=randi(nx);
%         q(r)=0;
%         S=find(q);
%         nf=length(S);
%     end
    
    % Ratio of Selected Features
    rf=nf/numel(q);
    
    % Selecting Features
    xs=x(S,:);
    
    % Weights of Train and Test Errors
    wTrain=0.8;
    wTest=1-wTrain;

    % Number of Runs
    nRun=1;
    EE=zeros(1,nRun);
    for r=1:nRun
        % Create and Train ANN
        results=TrainANN(xs,t);
        % Calculate Overall Error
        EE(r) = wTrain*results.TrainData.E + wTest*results.TestData.E;
    end
    
    E=mean(EE);
    acc_rate = sum(round(results.Data.y)==t)/numel(t); % accuracy rate 

    % Calculate Final Cost
    z=E;

    % Set Outputs
    out.S=S;
    out.nf=nf;
    out.rf=rf;
    out.E=E;
    out.z=z;
    out.A=acc_rate;    
    %out.net=results.net;
    out.Data=results.Data;
    %out.TrainData=results.TrainData;
    %out.TestData=results.TestData;    
end
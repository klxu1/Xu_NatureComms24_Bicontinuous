% NEed to make sure that the Positions excel spreadhseet you're using is
% the first excel sheet
clc
clear all
%Threshold of greater than 5 points fo the 0% to achieve 22 paths total
%(threw out 0wt_1 because it started with timepoint 2 instead of timepoint
%1
%Threshold of greater than 67 points for the 1% to achieve 26 paths total 
%Threshold of greater than 65 points for the 3% to achieve 21 paths total 

[file_name, path_name, filter_index] = uigetfile('*.xls', 'Select data', 'S:\data\');
temp=fullfile(path_name,'*.xls');
AllFiles=dir(temp);
c=1;
KeepTrackID=[];
for k=1:length(AllFiles) %for each file
    CurrentFile=readmatrix(AllFiles(k).name);
    [row,col]=size(CurrentFile);
    Totaltime=73;
    ArrayofTrajectory=[];
    TempData=[];
    for r=1:row %extract all of the TrackIDs
        if CurrentFile(r,7)==72
            TrackID(r)=CurrentFile(r,8);
        end
    end
    for a=1:length(TrackID) %go through each trackID
        if length(find(CurrentFile(:,8)==TrackID(a)))>60 %only take the paths for which there are enough data points
            FullTimeData{c,:}=CurrentFile(find(CurrentFile(:,8)==TrackID(a)),7);
            KeepTrackID=[KeepTrackID TrackID(a)];
            NCurrentFile{c}=CurrentFile(find(CurrentFile(:,8)==TrackID(a)),:);
            c=c+1;
        end
    end
end
    xys={};
for z=1:length(KeepTrackID)
    xys(NCurrentFile{z}(:,7),:)=[NCurrentFile{z}(:,1),NCurrentFile{z}(:,2),NCurrentFile{z}(:,3)];%try to make each row correspond to the time point and three values in each row correspond to x, y and z
    ZeroIndices=find(xys(:,1)==0);
    for h=1:length(ZeroIndices)
         xys(ZeroIndices(h),:)=xys(ZeroIndices(h)-1,:);
    end
    RealData{z}=xys;
end
Nc=length(RealData); % number of cell trajectories
cidk=jet(Nc); % generate different colors
figure(1)
for k=1:Nc
    CurrentPlot=RealData{k};
    CurrentPlot=CurrentPlot-ones(size(CurrentPlot)).*CurrentPlot(1,:); % Start from origin
    plot3(CurrentPlot(:,1),CurrentPlot(:,2),CurrentPlot(:,3),'-','color',cidk(k,:),'linewidth',1.5); 
    hold on;
end
axis ([-350 350 -350 350 -100 100])
xlabel('Migrated Distance (\mum)')
ylabel('Migrated Distance (\mum)')
zlabel('Migrated Distance (\mum)')

hold off;
%axis equal;


%% Code that I didn't end up using: 
% FullArrayTimeData=zeros(length(FullTimeData),73);
% for b=1:length(FullTimeData)%Fill in FullArrayTimeData with associated arrays 
%     for d=1:length(FullTimeData{b})
%        FullArrayTimeData(b,FullTimeData{b}(d))=FullTimeData{b}(d);
%        LastInd=d;
%     end
%     ZeroIndex=find(FullArrayTimeData(b,:)==0);
%     for Fill=1:length(ZeroIndex)
%         FullArrayTimeData(b,ZeroIndex)=FullArrayTimeData(b,ZeroIndex-1);
%     end
%     %find(CurrentData(:,8)==KeepTrackID(b) & CurrentData(:,7)==)
%     %PositionData{b}=[CurrentFile(:,8)]
% end
% keyboard 
%   if %only take the paths for which there are enough data points
%     for b=1:73
%         if TimeData(b)~=0
%             TempTimeData(a,TimeData(b))=b;
%             LastInd=b;
%         else 
%             TempTimeData(a,)
%         end
%     end   


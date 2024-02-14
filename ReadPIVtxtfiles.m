clear
clc
%import matplotlib.* 
%import matplotlib.pyplot.* 

[file_name, path_name, filter_index] = uigetfile('*.txt', 'Select data', 'S:\data\');
temp=fullfile(path_name,'*.txt');
AllFiles=dir(temp);
MaxVectorMag=[];
MaxPerpVectorMag=[];

x=input("Please put starting X (in pixel): ");
y=input("Please put starting Y (in pixel): ");
for k=1:length(AllFiles) %for each file
    AllFiles(k).name
    CurrentFile=readmatrix(AllFiles(k).name);
    BoxSize=76.7*(75/32.25);
    [ImageX,ImageY]=size(CurrentFile);
    VectorMag=[];
    PerpVectorMag=[];
    XVal=[];
    YVal=[];
    VecXVal=[];
    VecYVal=[];
    Mag=[];
    VectorMagIndex=1;
    for i=1:ImageX
        if CurrentFile(i,1)>x & CurrentFile(i,1)<x+(BoxSize*2)
            if CurrentFile(i,2)>y & CurrentFile(i,2)<y+(BoxSize/2)
                VectorMag=[VectorMag CurrentFile(i,5)];
                PerpVectorMag=[PerpVectorMag CurrentFile(i,4)];
            end
        end
        XVal=[XVal CurrentFile(i,1)];
        YVal=[YVal CurrentFile(i,2)];
        VecXVal=[VecXVal CurrentFile(i,3)];
        VecYVal=[VecYVal CurrentFile(i,4)];
        Mag=[Mag CurrentFile(i,5)];
    end
    MaxVectorMag=[MaxVectorMag max(VectorMag)];
    MaxPerpVectorMag=[MaxPerpVectorMag mean(PerpVectorMag)];
    figure(k)
    title(file_name,'Color','white')
    quiverc(XVal,YVal,VecXVal,VecYVal);
    colorbar
    axis equal
end
% all of my images are kind of flipped compared to Fiji, so just make sure
% to flip them over again. 
MaxVectorMag=[MaxVectorMag mean(VectorMag)];
MaxPerpVectorMag=[MaxPerpVectorMag mean(PerpVectorMag)]*-0.43; %0.43 um/pixel and *-1 so that up is really up 

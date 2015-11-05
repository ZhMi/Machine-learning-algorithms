%% Initialization
clear ; close all; clc

%%  Initial row data:
    % KMeansTestData is a file including test data : 2000 points(x,y) 
    DataSetArray = load('KMeansTestData');
    [height,width] = size(DataSetArray);
    
%% Data visualization 
    X = DataSetArray(:,1);
    y = DataSetArray(:,2);
    c = linspace(1,10,length(X));
    scatter(X,y,[],c,'d');

%% Initialize parameters    
    classier_num = input('class number:');
    maxiternum = 1000;
    DataSetArray(:, 3) = zeros(height, 1);
    currentIterNum = 0;
    equalAmount = 0;
%% Select randomly cluster centroid point
%     initaial_cluster_centroid_index = fix(rand(1,5)*20000);
%     cluster_centroid_point = DataSetArray(initaial_cluster_centroid_index,1:2)

%%  Select the original classier_num cluster center and use cluster centers in the first iteration
    
    % 如果要求在区间（a，b）内产生r = (m lines, n rows)均匀分布的随机数
    % r = a + (b-a).*rand([m n])); 
    % fix(r) save  the integer part and rounding the fractional part
    
    % clusterCenterArrayLineIndex store the line index of cluster centers 
    % amount of cluster centers : classier_num
    clusterCenterArrayLineIndex = fix((1 + (height - 1).*rand([1 classier_num])));
    clusterCenterArray = zeros(classier_num,2);
    for i = 1:classier_num
        tempIndex = clusterCenterArrayLineIndex(:,i);
        tempArray = DataSetArray(tempIndex,1:2);
        % clusterCenterArray is classier_num lines and two rows
        % every line is a point set of cluster center
        clusterCenterArray(i,:) =tempArray;
    end
    
%% Calculate the distance between the point K and each class and labled every point 
while currentIterNum <= maxiternum && equalAmount ~= 10
    % sum(x),sum(y) of every class 
    % sumPointValue 5*2 
    sumPointValue = zeros(5,2);
    % total number of the points of every class
    classPointNumber = zeros(1,5);
    newClusterCenter = zeros(5,2);
    for k = 1:height
        % the point k of DatSetArray
        tempPoint = DataSetArray(k,:);
        tempDistanceSet = zeros(1,classier_num);
        for j = 1:classier_num
            % get the j cluster center 
            tempClassierCenterPoint = clusterCenterArray(j,:);
            tempDistance = (tempPoint(1,1)-tempClassierCenterPoint(1,1))^2 + (tempPoint(1,2)-tempClassierCenterPoint(1,2))^2;
            tempDistanceSet(1,j) = tempDistance;
        end
        minDistancePoint = min(tempDistanceSet);
        % find lable of classier for every point
        pointClassierLable = find(tempDistanceSet == minDistancePoint);
        % lable every point and sum the total amount of every class
        DataSetArray(k,3) = pointClassierLable;
        sumPointValue(pointClassierLable,1:2)= sumPointValue(pointClassierLable,1:2) + DataSetArray(k,1:2);
        classPointNumber(1,pointClassierLable) = classPointNumber(1,pointClassierLable) + 1;
    end
    for i = 1:classier_num
        newClusterCenter(i,:) = sumPointValue(i,:) /  classPointNumber(1,i);
    end
    % judge if the next cluster center is the same as the last cluster center
    % if the same : return,stop iteration
    % else : continue iteration
    lastClusterCenter = clusterCenterArray(:);
    nextClusterCenter  = newClusterCenter(:);
    equalAmount = sum(nextClusterCenter == lastClusterCenter);
    currentIterNum = currentIterNum + 1;
    clusterCenterArray = newClusterCenter;
end

%% Visual data

%     % add a row labled as colour
%     color = ['b','g','r','c','m'];
%     colorSet = [];
%     for i = 1:height
%         lable = DataSetArray(i,3);
%         colorSet(1,i) = color(1,lable);
%     end
%     
%     scatter(X,y,[],colorSet);


classOne = []
classTwo = []
classThree = []
classFour = []
classFive = []


for i = 1:height
    lable = DataSetArray(i,3);
    switch(lable)
        case 1
            classOne = [classOne;DataSetArray(i,1:2)];
        case 2
            classTwo = [classTwo;DataSetArray(i,1:2)];
        case 3
            classThree = [classThree;DataSetArray(i,1:2)];
        case 4
            classFour = [classFour;DataSetArray(i,1:2)];
        case 5
            classFive= [classFive;DataSetArray(i,1:2)];
        otherwise
            break
    end
end

plot(classOne(:,1),classOne(:,2),'r',...
     classTwo(:,1),classTwo(:,2),'g',...
     classThree(:,1),classThree(:,2),'b',...
     classFour(:,1),classFour(:,2),'y',...
     classFive(:,1),classFive(:,2),'p')


    
  
    
    
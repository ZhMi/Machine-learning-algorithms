%% Machine Learning Online Class - Exercise 3 | Part 1: One-vs-all

%  Instructions
%  ------------
% 
%  This file contains code that helps you get started on the
%  linear exercise. You will need to complete the following functions 
%  in this exericse:
%
%     lrCostFunction.m (logistic regression cost function)
%     oneVsAll.m
%     predictOneVsAll.m
%     predict.m
%
%  For this exercise, you will not need to change any code in this file,
%  or any other files other than those mentioned above.
%

%% Initialization
clear ; close all; clc
%  clear ; close all; clc 
%          script文件中开头常见
%          clear all;清空工作区与全局变量
%          clc;清空命令区域
%          close all;关闭所有窗口
%          close;关闭当前窗口
%% Setup the parameters you will use for this part of the exercise
input_layer_size  = 400;  % 20x20 Input Images of Digits
num_labels = 10;          % 10 labels, from 1 to 10   
                          % (note that we have mapped "0" to label 10)

%% =========== Part 1: Loading and Visualizing Data =============
%  We start the exercise by first loading and visualizing the dataset. 
%  You will be working with a dataset that contains handwritten digits.
%
%  Load Training Data
%  You are given a data set in ex3data1.mat that contains 5000 training exam-
%  ples of handwritten digits.2 The .mat format means that that the data has
%  been saved in a native Octave/MATLAB matrix format, instead of a text
%  (ASCII) format like a csv -le These matrices can be read directly into your
%  program by using the load command. After loading, matrices of the correct
%  dimensions and values will appear in your memory of  program.The matrix
%  will already be named, so you do not need to assign names to them.

fprintf('Loading and Visualizing Data ...\n')
load('ex3data1.mat'); % training data stored in arrays X, y
                      % X is a matrix of 5000*400. There are 5000 training examples in ex3data1.mat, where each training
                      %   example is a 20 pixel by 20 pixel grayscale image of the digit.
                      % y is a matrix of 5000*1
                      %   y contains labels for the training set

m = size(X, 1);% get the rows of the matrix  X
               % size(X,2) means get the columns of the matrix

% Randomly select 100 data points to display
rand_indices = randperm(m);  % rand_indices is  5000 double 
                             % class（rand_indices） ---> double
sel = X(rand_indices(1:100), :); % rand_indices(1:100) is 1*100
                                 % rand select 100 training sets in matrix X
                                 % sel: 100*400 
                                 
displayData(sel);
% Visualizing Data

fprintf('Program paused. Press enter to continue.\n');
pause;

%% ============ Part 2: Vectorize Logistic Regression ============
%  In this part of the exercise, you will reuse your logistic regression
%  code from the last exercise. You task here is to make sure that your
%  regularized logistic regression implementation is vectorized. After
%  that, you will implement one-vs-all classification for the handwritten
%  digit dataset.
%

fprintf('\nTraining One-vs-All Logistic Regression...\n')

lambda = 0.1;
[all_theta] = oneVsAll(X, y, num_labels, lambda);

fprintf('Program paused. Press enter to continue.\n');
pause;


%% ================ Part 3: Predict for One-Vs-All ================
%  After ...
pred = predictOneVsAll(all_theta, X);

fprintf('\nTraining Set Accuracy: %f\n', mean(double(pred == y)) * 100);


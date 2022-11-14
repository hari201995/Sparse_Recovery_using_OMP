clear all;
close all;

 load('Y1 Y2 Y3 and A1 A2 A3.mat');
 [M,N]=size(A1);           
%  A1 = normc(A1);
 %% calling OMP
%  least_square_sol1 = pinv(A1)*y1;
%  [X_cap,Y_cap,index_set] = omp(A1,y1,N,M,0);
%  X_reshape = reshape(X_cap,[90,160]);
%  least_square_sol1_reshape = reshape(least_square_sol1,[90,160]);
%  figure('Name', 'A1-y1 combo')
%  X_image = imshow(X_reshape);
%  least_square_sol1_img = imshow(least_square_sol1_reshape);


 [M,N]=size(A2);           
 A2 = normc(A2);
 %% calling OMP
 least_square_sol2 = pinv(A2)*y2;
 [X_cap,Y_cap,index_set] = omp(A2,y2,N,M,0);
 X_reshape = reshape(X_cap,[90,160]);
 least_square_sol2_reshape = reshape(least_square_sol2,[90,160]);
 figure('Name', 'A2-y2 combo')
 X_image = imshow(X_reshape);
 least_square_sol2_img = imshow(least_square_sol2_reshape);

 [M,N]=size(A3);           
 A3 = normc(A3);
 %% calling OMP
 least_square_sol3 = pinv(A3)*y3;
 [X_cap,Y_cap,index_set] = omp(A3,y3,N,M,0);
 X_reshape = reshape(X_cap,[90,160]);
 least_square_sol3_reshape = reshape(least_square_sol3,[90,160]);
 figure('Name', 'A3-y3 combo')
 X_image = imshow(X_reshape);
 least_square_sol3_img = imshow(least_square_sol3_reshape);




        

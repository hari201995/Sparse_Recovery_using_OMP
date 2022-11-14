function [X,b_cap,index]= omp(A,b,N,l2_noise,noise_toggle,S,sparsity_unknown_toggle)
        r=b; 
        A_reduced=[];
        index=[];
        X=zeros(N,1);
        K=1; % number of times cols have been extracted
        
        %% Code for qn 3
        if noise_toggle == 0 
            err = 0.002;
            while err>=0.001
                b_cap = zeros(size(b));
                corr_mat = zeros(1,length(A));
                corr_mat = transpose(A)*r;
                [~, max_loc] = max(abs(corr_mat));
                [index] = [index max_loc];
                A_reduced = [A_reduced A(:,max_loc)];
                %obtain signal estimat
                X_est=pinv(A_reduced)*b;
                X(index,1)=X_est;
                b_cap = A*X;
                r = b-b_cap; 
                K=K+1;
                err = norm(r,2);
                if length(index)==N
                    break;
                end
            end
        end

        %% Code for part A of Qn: 4
        if (noise_toggle==1) && (sparsity_unknown_toggle==0)
           for ctr=1:S
                b_cap = zeros(size(b));
                corr_mat = zeros(1,length(A));
                corr_mat = transpose(A)*r;
                [~, max_loc] = max(abs(corr_mat));
                 %duplicate check
                duplicate_index = index==max_loc;
                if sum(duplicate_index) >0
                    [~, new_index] = maxk(abs(corr_mat),2);
                    max_loc  = new_index(2);
                end
                [index] = [index max_loc];
                A_reduced = [A_reduced A(:,max_loc)];
                %obtain signal estimat
                X_est=pinv(A_reduced)*b;
                X(index,1)=X_est;
                b_cap = A*X;
                r = b-b_cap; 
            end
        end

   %% Code for Part B of Question 4. 

        if (noise_toggle==1) && (sparsity_unknown_toggle==1)
            while norm(r,1)>= l2_noise
                b_cap = zeros(size(b));
                corr_mat = zeros(1,length(A));
                corr_mat = transpose(A)*r;
                [~, max_loc] = max(abs(corr_mat));
                 %duplicate check
                duplicate_index = index==max_loc;
                if sum(duplicate_index) >0
                    [~, new_index] = maxk(abs(corr_mat),2);
                    max_loc  = new_index(2);
                end
                [index] = [index max_loc];
                A_reduced = [A_reduced A(:,max_loc)];
                %obtain signal estimat
                X_est=pinv(A_reduced)*b;
                X(index,1)=X_est;
                b_cap = A*X;
                r = b-b_cap; 
            end
        end
end










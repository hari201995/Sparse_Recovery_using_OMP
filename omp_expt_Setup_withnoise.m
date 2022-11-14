%% INSTRUCTIONS TO RUN THE CODE ARE IN THE REPORT SUBMITTED.
close all
clear all
col_size=[20 50 100];

%% Enter the itr value corresponding to the value of N to be chosen from col_size variable. 
for itr=3

    N=col_size(itr) ;
    ESR_cols=[];

    for M=1:N  % interating rows 
            ESR=[];
            %% generating i/p
            for S=1:N  % iterating Sparsity
                count_esr=0;
                for rnd=1:2000    % Monte carlo runs    
                   %% Generating matrix
                    for r=1:M
                        A(r,:) = randn([1,N]);
                        A(r,:) = normc(A(r,:));
                    end
                    X = zeros(N,1);
                    indices = randperm(N,S); % Non zero indices chosen randomly
                    r1 = 1 + (9).*rand(S,1);
                    r2= -10 + (9).*rand(S,1);
                    R=[r1' r2'];
                    val_idx= randi(length(R),[1,S]);
                    value_X= R(val_idx);
                    X(indices)= value_X;

                    %% generating noise
                    noise = normrnd(0,10^-9,M,1);
                    Y=A*X+noise;
                    l2_norm_noise = norm(noise,2);
                    
                    %% toggle this accordingly if we want to run with known sparsity or not. sparsity_unknown=1 will 
                    %% terminate with the condition ||Y-Ax(k)|| <= norm(noise,2)
                    sparsity_unknown = 1;

                    %% calling OMP
                    [X_cap,Y_cap,index_set] = omp(A,Y,N,l2_norm_noise,1,S,sparsity_unknown);
                   
                    %% Metric calculations
                    % ESR computation
                    norm_err = norm(X-X_cap,2)/norm(X,2);
                    if norm_err <= 0.001
                        count_esr=count_esr+1;
                    end
                end
                ESR=[ESR count_esr/2000];
            end
        ESR_cols=[ESR_cols ESR'];
        disp(M);
        disp('done');
    end
end

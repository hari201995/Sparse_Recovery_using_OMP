close all
clear all
col_size=[20 50 100];

for itr=1
    N=col_size(itr) ;
    ESR_cols=[];
    for M=1:N
            ESR=[];
            norm_mat=[];
            %% generating i/p
            for S=1:N
                count_esr=0;
                norm_err=0;
                T = table(N,M,S, 'VariableNames', { 'N', 'M', 'S'} );
                % Write data to text file
                writetable(T, 'sim.txt')
                for rnd=1:2000              
                   %% Generating matrix
                    for r=1:M
                        A(r,:) = randn([1,N]);
                        A(r,:) = normc(A(r,:));
                    end
                    X = zeros(N,1);
                    %S= randi(N); % random Support of X
                    indices = randperm(N,S); % Non zero indices chosen randomly
                    r1 = 1 + (9).*rand(S,1);
                    r2= -10 + (9).*rand(S,1);
                    R=[r1' r2'];
                    val_idx= randi(length(R),[1,S]);
                    value_X= R(val_idx);
                    X(indices)= value_X;
                    X= normc(X);
                    Y=A*X;
                    %% calling OMP
                    [X_cap,Y_cap,index_set] = omp(A,Y,N,0,0,0);
                    %% Metric calculations
                    % ESR computation
                    if length(index_set) == length(indices)
                            if sort(index_set) == sort(indices)
                                    count_esr=count_esr+1;
                            end
                    end
                     norm_err = norm_err+ norm(X-X_cap,2)/norm(X,2);
                end
                ESR=[ESR count_esr/2000];
                norm_mat=[norm_mat norm_err/2000];
            end
        ESR_cols=[ESR_cols ESR'];
        norm_cols =[norm_cols norm_mat'];
    end
end

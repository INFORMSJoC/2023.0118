Gamma = 1*10^5;
rep = 10000;
result = zeros(rep,3);
fid = fopen("EIG_10w_Two_Jack_0_2.txt","a");
for i = 1:rep
    i
    tic;
    result(i,:) = Two_level_EIG(Gamma);
    for j = 1:3
        if j == 3
            fprintf(fid,'%14.10f\n',result(i,j));
        else
            fprintf(fid,'%14.10f\t',result(i,j));
        end
    end
    toc;
end
fclose(fid);
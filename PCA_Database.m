%build PCA_Database
%function PCA_Database
%flatten 
image_all = [];
%类别数目40
for i = 1:40
    %样本数目
    for j = 1:5
        image = imread(['C:\Users\volca\Desktop\PCA maTLAB\attfaces\s',num2str(i),'\' ,num2str(j),'.pgm']);
        image_flat = reshape(image,[10304,1]);
        image_all = [image_all,image_flat];
    end
end
samples = double(image_all);
samples_mean = mean(samples,2);
samples_zeros_mean = samples - samples_mean;
%cov matrix is (1/N)*samples_zeros_mean*samples_zeros_mean.'
%SVD
%C为协方差矩阵
C = (samples_zeros_mean.'*samples_zeros_mean)/(40*5);
%特征值&特征向量
[v,d] = eig(C);
d1 = diag(d);
%排序
dsort = flipud(d1);
vsort = fliplr(v);
%将原数据将至200维
%基
coordinate_temp = samples_zeros_mean*vsort(:,1:200)*diag(dsort(1:200).^(-1/2));
coordinate = coordinate_temp(:,1:200);
trans_all_image =coordinate.'* samples;
save('base','coordinate','trans_all_image','samples_mean');













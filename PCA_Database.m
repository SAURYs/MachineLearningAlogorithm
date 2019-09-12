%build PCA_Database
%function PCA_Database
%flatten 
image_all = [];
%�����Ŀ40
for i = 1:40
    %������Ŀ
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
%CΪЭ�������
C = (samples_zeros_mean.'*samples_zeros_mean)/(40*5);
%����ֵ&��������
[v,d] = eig(C);
d1 = diag(d);
%����
dsort = flipud(d1);
vsort = fliplr(v);
%��ԭ���ݽ���200ά
%��
coordinate_temp = samples_zeros_mean*vsort(:,1:200)*diag(dsort(1:200).^(-1/2));
coordinate = coordinate_temp(:,1:200);
trans_all_image =coordinate.'* samples;
save('base','coordinate','trans_all_image','samples_mean');













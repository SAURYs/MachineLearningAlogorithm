%binarization
%binarilization 
%using max entropy to calculate the threshold.
function bw_image = binaried(filename)
%using K-L algorithm to get optimal threshold
image = imread(filename);
image_gray = rgb2gray(image);
%imshow(image_gray);
[num_row,num_col]=size(image_gray);
% p is the number of different intensities(0~255)
p = imhist(image_gray);
%Probability density
p_density = (p/(num_row*num_col));
p_distribution = cumsum(p_density);
x=[];
y=[];
for j = 1:1:256
    %Before each iteration,the program has to clean x,y,because every loop
    %will have their x and y.They store x,y at  the same place.
  x=[];
y=[];
    back =p_distribution(j);
    fore =1-back;
    if back~=0
        for jj =1:j
            if p_density(jj)~=0
                x(jj) = (p_density(jj)/back)*(log(p_density(jj)/back));
            else
                x(jj)=0;
            end
        end
        h0(j)=-sum(x);
    else
        h0(j)=0;
    end
    if fore~=0
        for j_ =( j+1):1:256
            if p_density(j_)~=0
                y(j_-j) = (p_density(j_)/fore)*(log(p_density(j_)/fore));
            else
                y(j_-j)=0;
            end
        end
        h1(j)=-sum(y);
    else
        h1(j)=0;
    end
    H1(j) = h0(j)+h1(j);
end

[~,threshold] =max(H1);
bw_image=im2bw(image_gray,(threshold-1)/255);
%imshow(bw_image);
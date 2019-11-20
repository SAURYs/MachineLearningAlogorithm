%binarilization and connected component analysis
%using max entropy to calculate the threshold.
rice_rgb = imread('rice.jpg');
%using K-L algorithm to get optimal threshold
rice_gray = rgb2gray(rice_rgb);
imshow(rice_gray);
% p is the number of different intensities(0~255)
p = imhist(rice_gray);
%Probability density
p_density = (p/(256*256));
p_distribution = cumsum(p_density);
x=[];
y=[];
for j = 1:1:256
    %Before each iteration,the program has to clean x,y,because every loop
    %will have their x and y.They store x,y at  the same place.
    clear x;
    clear y;
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
rice_bw=im2bw(rice_gray,(threshold-1)/255);
        


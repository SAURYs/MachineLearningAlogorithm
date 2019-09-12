%im
 image = imread('C:\Users\volca\Desktop\PCA maTLAB\attfaces\s39\7.pgm');
 imshow(image);
 image_flat_uint8 = reshape(image,[10304,1]);
 %为何这里也要零均值化呢？
 image_flat = double(image_flat_uint8);
 trans_image = coordinate.'*image_flat;
 for i = 1:200
     distance(i) = norm(trans_all_image(:,i)-trans_image,2);
 end
 [value,index]=min(distance);
 if index<5
     person = 1 ;
 elseif(mod(index,5)==0)
     person = index/5;
 else
     person = floor(index/5)+1;
 end
 fprintf('the picture is the %sth person\n',num2str(person));

 
     

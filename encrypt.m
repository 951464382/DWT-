a=imread('test.jpg');
subplot(2,2,1);
imshow(a);
title('‘≠Õº');
%% keys
keys=hui_3(0.91,size(a(:,:,1),1),size(a(:,:,1),2));
subplot(2,2,2);
imshow(keys);
title('√‹‘ø');
%% jia_mi
mi_a=bitxor(keys,a);
subplot(2,2,3);
imshow(mi_a);
imwrite(uint8(mi_a),'testjiam.jpg');
title('º”√‹');
%% ji_mi
ji_a=bitxor(keys,mi_a);
subplot(2,2,4);
imshow(ji_a);
title('Ω‚√‹');
%%
function M1=hui_3(x,m,n)
rng(x,'twister');
M1=round(rand([m n])*255);
M1=uint8(M1);
end
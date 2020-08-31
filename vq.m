clear all 
close all
I=double(imread('test1.jpg'));
figure(1);
imshow(uint8(I));
[originx,originy,originz]=size(I); %初始图像大小
originx
originy
originz
cb=importdata ('codebook.txt'); 
[row,col]=size(cb);         %codebook的大小
file1=fopen('vq.txt','wt'); %vq的值存储的文件
%% 第一维度分解压缩
[om,on,ok]=size(I(:,:,1));  %分解后的大小
B=im2col(I(:,:,1),[4,4],'distinct');% 将图像分解为16*(128*128)的矩阵
[m,n,k]=size(B);              %分解后的大小
finaly=0
for j =1:n
    finaly=finaly+1;%% vq
    min=9999999;
    index=-1;  
    for k=1:256
         temp=0;
        for p=1:16
           temp=temp+(B(p,j)-cb(k,p))^2;
        end
        if temp<=min
            min=temp;
            index=k;
        end
    end
    tempvq(finaly,1)=index-1;
end
%figure(1);
%imshow(uint8(tempvq));
for i=1:n
    for j=1:16
        temp(j,i)=cb(tempvq(i,1)+1,j);
    end
end
figure(2);
img1=col2im(temp,[4,4],[om,on],'distinct');
%imshow(uint8(img1));
%figure(2);
%imshow(uint8(Double_Img));
%% 第二维度分解压缩
B=im2col(I(:,:,2),[4,4],'distinct');% 将图像分解为16*(128*128)的矩阵
[m,n,k]=size(B);              %分解后的大小
%figure(3);
%imshow(uint8(I(:,:,2)));
m
n
k
finaly=0
for j =1:n
    finaly=finaly+1;%% vq
    min=9999999;
    index=-1;  
    for k=1:256
         temp=0;
        for p=1:16
           temp=temp+(B(p,j)-cb(k,p))^2;
        end
        if temp<=min
            min=temp;
            index=k;
        end
    end
    tempvq(finaly,1)=index-1;
end
%figure(1);
%imshow(uint8(tempvq));
for i=1:n
    for j=1:16
        temp(j,i)=cb(tempvq(i,1)+1,j);
    end
end
%figure(2);
img2=col2im(temp,[4,4],[om,on],'distinct');
%imshow(uint8(img2));
%% 第三维度分解压缩
B=im2col(I(:,:,3),[4,4],'distinct');% 将图像分解为16*(128*128)的矩阵
[m,n,k]=size(B);              %分解后的大小
%figure(1);
%imshow(uint8(I(:,:,3)));
m
n
k
finaly=0
for j =1:n
    finaly=finaly+1;%% vq
    min=9999999;
    index=-1;  
    for k=1:256
         temp=0;
        for p=1:16
           temp=temp+(B(p,j)-cb(k,p))^2;
        end
        if temp<=min
            min=temp;
            index=k;
        end
    end
    tempvq(finaly,1)=index-1;
end
%figure(1);
%imshow(uint8(tempvq));
for i=1:n
    for j=1:16
        temp(j,i)=cb(tempvq(i,1)+1,j);
    end
end
%figure(2);
img3=col2im(temp,[4,4],[om,on],'distinct');
%imshow(uint8(img2));
%% 拼接维度
%I(:,:,1)=img1;
%I(:,:,2)=img2;
%I(:,:,3)=img3;
I=cat(3,img1,img2,img3);
figure(2);
imshow(uint8(I));
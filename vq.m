clear all 
close all
I=double(imread('test1.jpg'));
figure(1);
imshow(uint8(I));
[originx,originy,originz]=size(I); %��ʼͼ���С
originx
originy
originz
cb=importdata ('codebook.txt'); 
[row,col]=size(cb);         %codebook�Ĵ�С
file1=fopen('vq.txt','wt'); %vq��ֵ�洢���ļ�
%% ��һά�ȷֽ�ѹ��
[om,on,ok]=size(I(:,:,1));  %�ֽ��Ĵ�С
B=im2col(I(:,:,1),[4,4],'distinct');% ��ͼ��ֽ�Ϊ16*(128*128)�ľ���
[m,n,k]=size(B);              %�ֽ��Ĵ�С
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
%% �ڶ�ά�ȷֽ�ѹ��
B=im2col(I(:,:,2),[4,4],'distinct');% ��ͼ��ֽ�Ϊ16*(128*128)�ľ���
[m,n,k]=size(B);              %�ֽ��Ĵ�С
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
%% ����ά�ȷֽ�ѹ��
B=im2col(I(:,:,3),[4,4],'distinct');% ��ͼ��ֽ�Ϊ16*(128*128)�ľ���
[m,n,k]=size(B);              %�ֽ��Ĵ�С
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
%% ƴ��ά��
%I(:,:,1)=img1;
%I(:,:,2)=img2;
%I(:,:,3)=img3;
I=cat(3,img1,img2,img3);
figure(2);
imshow(uint8(I));
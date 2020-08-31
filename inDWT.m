close all;
clear all;
%����ͼ��
X=imread('test1.jpg');
%αװͼ��
I=double(imread('boat.512.tiff'));
%��ȡαװͼ����ά
[i,j,k]=size(I);
[i1,j1,k1]=size(I);
%ѹ��
I=imresize(I,[i/2 j/2]);
%��������ͼ��αװͼ����ı�
i=imresize(X,[i j]);
sX=size(i);
%% DWT
[LL,LH,HL,HH]= dwt2(i,'db1');
%% ����
pre_encrypted_Img=hui_3(x,size(I(:,:,1),1),size(I(:,:,1),2));;
mi_a=bitxor(uint8(pre_encrypted_Img),uint8(I));
[x,y,z]=size(uint8(mi_a));
%% ����
CV=mi_a;
CD=mi_a;
for f1 =1:x
    for f2 =1:y
        for f3 =1:z
            CV(f1,f2,f3)=mod(mi_a(f1,f2,f3),16);
            CD(f1,f2,f3)=fix(mi_a(f1,f2,f3)/16);
        end
    end   
end
%% ��DWT
Xrec=idwt2(LL,LH,CD,CV,'db1',sX);
[x,y,z]=size(uint8(Xrec));
I=imresize(I,[i1 j1]);
figure(3);
subplot(2,2,1);imshow(uint8(Xrec));title('���ؼ���ͼ���Ĳ���ͼ��');
subplot(2,2,2);imshow(uint8(CD));title('CD');
subplot(2,2,3);imshow(uint8(CV));title('CV');
subplot(2,2,4);imshow(uint8(I));title('�����ͼ��');
function M1=hui_3(x,m,n)
rng(x,'twister');
M1=round(rand([m n])*255);
M1=uint8(M1);
end
close all;
clear all;
X=imread('test.jpg');
i=imresize(X,[512 512]);
figure(1);
sX=size(X);
[LL,LH,HL,HH]= dwt2(X,'db1');
%figure(2)
subplot(2,2,1);imshow(uint8(LL));title('LL band of image');
subplot(2,2,2);imshow(uint8(LH));title('LH band of image');
subplot(2,2,3);imshow(uint8(HL));title('HL band of image');
subplot(2,2,4);imshow(uint8(HH));title('HH band of image');
[x,y,z]=size(uint8(HH));
x
y
z
I=double(imread('boat.512.tiff'));
 Xrec=idwt2(LL,LH,HL,HH,'db1',sX);
% sx=size(X)
% A1=idwt2(LL,[],[],[],'db1',sX);
% H1=idwt2([],LH,[],[],'db1',sX);
% V1=idwt2(LL,[],HL,[],'db1',sX);
% D1=idwt2(LL,[],[],HH,'db1',sX);
% max(max(abs(i-Xrec)));
figure(2);
imshow(uint8(Xrec));
function imagetest1()
Y = ((imread('C:\Users\admin\Pictures\test2.jpg')));%伪装图像
X=double(Y);
newCV = (double(imread('C:\Users\admin\Pictures\图片1.png')));
[m,n]=size(newCV);
m
n
liftscheme = liftwave('haar','int2int');  %分解方法
m=int16(m);
n=int16(n);
temp=X(1:346,1:1920);
[m,n]=size(temp);
m
n
[LL1 LH1 HL1 HH1]=lwt2(Y,liftscheme);%分解
[x,y]=size(HL1);
x
y
%HL1=temp;
Y0 = ilwt2(LL1, LH1, HL1, HH1,liftscheme);%还原
imwrite(Y0,'C:\Users\admin\Pictures\test3.jpg')
end
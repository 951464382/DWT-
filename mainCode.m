
clear all 
close all
I=double(imread('boat.512.tiff'));
[originx,originy]=size(I); %��ʼͼ���С
B=im2col(I,[4,4],'distinct');% ��ͼ��ֽ�Ϊ16*(128*128)�ľ���
[m,n]=size(B);              %�ֽ��Ĵ�С
m
n
cb=importdata ('codebook.txt'); 
[row,col]=size(cb);         %codebook�Ĵ�С
row
col
finaly=0
file1=fopen('vq.txt','wt'); %vq��ֵ�洢���ļ�
sym temp;
sym index;
sym min;
for j =1:16384
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
    vq(1,finaly)=index-1;
end
for f1 =1:1
    for f2 =1:16384
            fprintf(file1,'%d\r\n',vq(f1,f2));%����
    end
       
end
fclose(file1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all 
close all
originvq=importdata ('vq.txt');   %��vq���ͼƬ
temp=0;
for j=1:128
    for i=1:128
        temp=temp+1;
        Double_Img(i,j)=originvq(temp,1);
    end
end
pre_encrypted_Img=Double_Img;
CD=Double_Img;
CV=Double_Img;

[m,n]=size(Double_Img); %���к���
Double_key=randi([0,255],m,n) %����ͬ�����������

%%%%count=1;
file1=fopen('origin_values.txt','wt'); %��ʼ��ֵ
file2=fopen('key_values.txt','wt'); %���������ֵ
file3=fopen('final_values.txt','wt'); %���֮���ֵ
file5=fopen('CD.txt','wt') %CDֵ
file4=fopen('CV.txt','wt') %CVֵ
%%%%count=0;
for f1 =1:m
    for f2 =1:n
     
       if f2==n
            fprintf(file1,'%d\r\n',Double_Img(f1,f2));%����
            fprintf(file2,'%d\r\n',Double_key(f1,f2));%����          
            %%%%%%�������%%%%%
            fprintf(file3,'%d\r\n',bitxor(Double_Img(f1,f2),Double_key(f1,f2)));%����
            pre_encrypted_Img(f1,f2)=bitxor(Double_Img(f1,f2),Double_key(f1,f2));
            %%%%%%DWTCT%%%%%%%
            CV(f1,f2)=mod(pre_encrypted_Img(f1,f2),16);
            CD(f1,f2)=fix(pre_encrypted_Img(f1,f2)/16);
            fprintf(file4,'%d\r\n',CV(f1,f2));%����
            fprintf(file5,'%d\r\n',CD(f1,f2));%����
        else
            fprintf(file1,'%d\t',Double_Img(f1,f2));%tab
            fprintf(file2,'%d\t',Double_key(f1,f2));%tab           
            %%%%%%�������%%%%%
            fprintf(file3,'%d\t',bitxor(Double_Img(f1,f2),Double_key(f1,f2)));%tab
            pre_encrypted_Img(f1,f2)=bitxor(Double_Img(f1,f2),Double_key(f1,f2));
            %%%%%%DWTCT%%%%%%%
            CV(f1,f2)=mod(pre_encrypted_Img(f1,f2),16);
            CD(f1,f2)=fix(pre_encrypted_Img(f1,f2)/16);
            fprintf(file4,'%d\t',CV(f1,f2));%tab
            fprintf(file5,'%d\t',CD(f1,f2));%tab
       end

    end
       
end

%%%%% �ر���
fclose(file1);
fclose(file2);
fclose(file3);
fclose(file4);
fclose(file5);

for i=1:128
    for j=1:128
      
      tempcv=dec2bin(CV(i,j));
      tempcd=dec2bin(CD(i,j));
      
      tempcv=str2double(tempcv);
      tempcd=str2double(tempcd);
      
      newCV(i,j)=fix(tempcv/1000);
      newCV(i,j+128)=fix(mod(tempcv,1000)/100);
      newCV(i+128,j)=fix(mod(tempcv,100)/10);
      newCV(i+128,j+128)= mod(tempcv,10);
      
      newCD(i,j)=fix(tempcd/1000);
      newCD(i,j+128)=fix(mod(tempcd,1000)/100);
      newCD(i+128,j)=fix(mod(tempcd,100)/10);
      newCD(i+128,j+128)= mod(tempcd,10);
    end
end

%%%%%%%%%%%DWT
Y=imread('5.2.08.tiff');
X=double(Y);
liftscheme = liftwave('haar','int2int');  %�ֽⷽ��
[LL1 LH1 HL1 HH1]=lwt2(X,liftscheme);%�ֽ�
HL1=newCV;
HH1=newCD;
Y0 = ilwt2(LL1, LH1, HL1, HH1,liftscheme);%��ԭ


file6=fopen('Y0.txt','wt'); %Y0��ֵ
for f1 =1:512
    for f2 =1:512
     
       if f2==512
            fprintf(file6,'%d\r\n',Y0(f1,f2));%����
        else
            fprintf(file6,'%d\t',Y0(f1,f2));%tab
          
       end

    end
       
end

fclose(file6);

%%%% ���ͼ��
Double_Img=uint8(Double_Img);
Img=uint8(Y0);
imgCD=uint8(newCV);
imgCV=uint8(newCD);
disp('����ͼ����psnr��');
imgPSNR(Y,Img);

subplot(2,2,1);imshow(Y);title('ԭͼ');
subplot(2,2,2);imshow(Img);title('��ϢͼƬ');
subplot(2,2,3);imshow(imgCV);title('CV');
subplot(2,2,4);imshow(imgCD);title('CD');
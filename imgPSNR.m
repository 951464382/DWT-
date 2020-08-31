function psnr = imgPSNR(img,imgComp)
% Input
%   	img : ԭʼ֡
%   	imgComp : Ԥ��֡
% Ouput
%   	psnr : �˶��������ͼ���PSNR

img = double(img);
imgComp = double(imgComp);
[m,n]=size(img);

B=8;                                      %����һ�������ö��ٶ�����λ
MAX=2^B-1;                                %ͼ���ж��ٻҶȼ�
MSE=sum(sum((img-imgComp).^2))/(m*n);     %������
psnr=10*log10(MAX^2/MSE);                 %��ֵ����
disp(psnr);
end

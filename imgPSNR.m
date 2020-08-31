function psnr = imgPSNR(img,imgComp)
% Input
%   	img : 原始帧
%   	imgComp : 预测帧
% Ouput
%   	psnr : 运动补偿后的图像的PSNR

img = double(img);
imgComp = double(imgComp);
[m,n]=size(img);

B=8;                                      %编码一个像素用多少二进制位
MAX=2^B-1;                                %图像有多少灰度级
MSE=sum(sum((img-imgComp).^2))/(m*n);     %均方差
psnr=10*log10(MAX^2/MSE);                 %峰值信噪
disp(psnr);
end

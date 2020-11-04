close all; clear all; clc;

%%1) Leitura da imagem
I = imread('img.png');
figure
imshow(I);

%%2) Separa nas componentes RGB
figure
subplot(2,2,1)
imshow(I);
title('Imagem Original')

red = I(:, :, 1);
subplot(2,2,2), imshow(red);
title('Canal vermelho')

green = I(:, :, 2);
subplot(2,2,3), imshow(green);
title('Canal verde')

blue = I(:, :, 3);
subplot(2,2,4), imshow(blue);
title('Canal azul')

%%3) Separa nas componentes HSI
figure
subplot(2,2,1)
imshow(I);
title('Imagem Original')

HSV = rgb2hsv(I);

H = HSV(:, :, 1);
subplot(2,2,2), imshow(H);
title('Matiz')

S = HSV(:, :, 2);
subplot(2,2,3), imshow(S);
title('Saturação')

V = HSV(:, :, 3);
subplot(2,2,4), imshow(V);
title('Intensidade')


%%4) Incluir um ruído
figure
subplot(1,2,1)
imshow(I);
title('Imagem Original')

ruidoG = imnoise(I,'gaussian', 0.15, 0.05);
subplot(1,2,2), imshow(ruidoG);
title('Ruído Gaussiano')

%%5) Aplicar filtro e restaurar a imagem
figure
subplot(1,3,1)
imshow(I);
title('Imagem Original')

subplot(1,3,2), imshow(ruidoG);
title('Ruído Gaussiano')

f_media = fspecial('average',4);
filtroM = imfilter(ruidoG, f_media);
subplot(1,3,3), imshow(filtroM)
title('Filtro de média')

%%6) Incluir ruído nos canais HSI
figure
subplot(1,2,1)
imshow(HSV);
title('Imagem Original HSI')

ruidoGHSI = imnoise(HSV,'salt & pepper', 0.15);
subplot(1,2,2), imshow(ruidoGHSI);
title('Ruído Salt & Pepper HSI')

%%7) Aplicar filtro e restaurar a imagem
figure
subplot(1,3,1)
imshow(HSV);
title('Imagem Original HSI')

subplot(1,3,2), imshow(ruidoGHSI);
title('Ruído Salt & Pepper HSI')

img_filtered = ruidoGHSI;
for c = 1 : 3
    img_filtered(:, :, c) = medfilt2(ruidoGHSI(:, :, c), [3, 3]);
end
subplot(1,3,3), imshow(img_filtered);
title('Filtro de mediana')

%% New Figures
clc, clearvars, close all
M1 = imread('mel01.png'); % Healthy
M2 = imread('mel02.png'); % Low density
M3 = imread('mel03.png'); % High density

disp...
    ('From the original images: melanoma looks different in color and size.')

% Original images                       ------------------------------
h1 = figure;
subplot(231)
imshow(M1)
title('Healthy cell')

subplot(232)
imshow(M2)
title('Low density melanoma')

subplot(233)
imshow(M3)
title('High density melanoma')

% To grayscale                      -----------------------------------
M1g = rgb2gray(M1);
M2g = rgb2gray(M2);
M3g = rgb2gray(M3);

subplot(234)
imshow(M1g), title('Healthy cell - grayscale')

subplot(235)
imshow(M2g), title('LD Melanoma - grayscale')

subplot(236)
imshow(M3g), title('HD Melanoma - grayscale')


% Histograms                        -----------------------------------
M1h = imhist(M1g); M1h = M1h/max(M1h);
M2h = imhist(M2g); M2h = M2h/max(M2h);
M3h = imhist(M3g); M3h = M3h/max(M3h);

h2 = figure;
subplot(231)
imshow(M1g)
imshow(M1g), title('Healthy cell - grayscale')

subplot(232)
imshow(M2g), title('LD Melanoma - grayscale')

subplot(233)
imshow(M3g), title('HD Melanoma - grayscale')

subplot(234)
plot(M1h), axis([0 255 0 0.05]), title('Healthy cell - histogram')

subplot(235)
plot(M2h), axis([0 255 0 0.05]), title('LD melanoma - histogram')

subplot(236)
plot(M3h), axis([0 255 0 0.05]), title('HD melanoma - histogram')

% Binarization                  -----------------------------------------
tr = 90;    % Threshold

M1b = binz(M1g, tr);
M2b = binz(M2g, tr);
M3b = binz(M3g, tr);

h3 = figure;
subplot(231)
imshow(M1b), title('Healthy cell - binarization')

subplot(232)
imshow(M2b), title('LD melanoma - binarization')

subplot(233)
imshow(M3b), title('HD melanoma - binarization')

% Morphological operations      ---------------------------------------
SE = strel('disk', 1); % Structural element

% Closing
M1b_e = imclose(M1b, SE);
M2b_e = imclose(M2b, SE);
M3b_e = imclose(M3b, SE);

SE = strel('disk', 3); % Structural element
M1b_e = imerode(M1b_e, SE);
M2b_e = imerode(M2b_e, SE);
M3b_e = imerode(M3b_e, SE);

subplot(234)
imshow(M1b_e), title('Healthy cell - closure + erosion')

subplot(235)
imshow(M2b_e), title('LD melanoma  - closure + erosion')

subplot(236)
imshow(M3b_e), title('HD melanoma - closure + erosion')


% Inversion from black to white (to use labeling functions)
invM1b_e = abs(M1b_e-255); 
invM2b_e = abs(M2b_e-255);
invM3b_e = abs(M3b_e-255);

ccM1 = bwconncomp(invM1b_e);
ccM2 = bwconncomp(invM2b_e);
ccM3 = bwconncomp(invM3b_e);

numM1 = ccM1.NumObjects;
numM2 = ccM2.NumObjects;
numM3 = ccM3.NumObjects;


%%
function Ib = binz(I, tr)
% This function allows to binarize an Image considering a trehshold.
% Inputs :  
%            I : Image (bidimensional array)
%            tr: Binarization threshold (Scalar)
% Outputs:
%            Ib: Binarized image
%

Ib = zeros(size(I, 1), size(I, 2));

for m = 1: size(I, 1)
    for n = 1: size(I, 2)
        if I(m, n) <= tr
            
            Ib(m, n) = 0;
        else
            Ib(m, n) = 255;
        end
    end

end
end
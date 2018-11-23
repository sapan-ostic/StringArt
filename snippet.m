img = imread('beardo.jpg');
figure(1);
imshow(img);
img2 = imresize(img,0.25);
figure(2);
imshow(img2);
BW = im2bw(img,0.5);
figure(3)
imshow(BW)


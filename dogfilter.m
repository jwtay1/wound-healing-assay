function mask = dogfilter(Iin)

Igauss1 = imgaussfilt(Iin, 1);
Igauss2 = imgaussfilt(Iin, 5);


Idog = Igauss1 - Igauss2;
%imshow(Idog, [])
mask = Idog > 2000;
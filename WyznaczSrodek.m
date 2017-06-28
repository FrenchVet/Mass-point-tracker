function [ x, y ] = WyznaczSrodek( pkt1, pkt2, d, dlSegmentu)
a = (pkt1(2)-pkt2(2))/(pkt1(1)-pkt2(1));%wyznaczenie prostej na ktorej leza punkty
b = pkt1(2)-a*pkt1(1);
c = (pkt1(1)-pkt2(1))*d/dlSegmentu;%odleglosc X od punktu bazowego z tw Talesa. Zachowany jest znak, zeby okresllic w ktora strone
x = pkt1(1)-c;%wspolrzednie srodka beda wspolrzedna X bazy pomniejszona o wynik z Tw Talesa
y = a*x+b;%wspolrzedna y jest obliczana z rownania prostej
end


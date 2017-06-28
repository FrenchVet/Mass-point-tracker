function [ kat ] = WyznaczKat( pkt1, pkt2  ) %wzgledem pkt1
if(pkt1(1)-pkt2(1) == 0)
    if(pkt1(2)-pkt2(2) > 0)
        kat = 3*pi/2;
    else
        kat = pi/2;
    end
else
    kat = 2*pi-atan((pkt1(1)-pkt2(1))/(pkt1(2)-pkt2(2)));
end


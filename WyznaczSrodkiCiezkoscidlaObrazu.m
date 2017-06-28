function TrajektorieSrodkow =  WyznaczSrodkiCiezkoscidlaObrazu(Punkty)
        TrajektorieSrodkow = cell(9,1);
        
        % Potrzebne dane:
        dl_ramienia = OdlegloscPunktow(Punkty{2},Punkty{3});
        dl_przedramienia = OdlegloscPunktow(Punkty{3},Punkty{4});
        dl_dloni = OdlegloscPunktow(Punkty{4},Punkty{5});
        dl_glowy = OdlegloscPunktow(Punkty{1},Punkty{2});
        dl_uda = OdlegloscPunktow(Punkty{6},Punkty{7});
        dl_podudzia = OdlegloscPunktow(Punkty{7},Punkty{8});
        dl_stopy = OdlegloscPunktow(Punkty{9},Punkty{10});
        dl_tulowia = OdlegloscPunktow(Punkty{2},Punkty{6});
        
        %potrzebne masy i proporcje w ktorych lezy srodek masy
        
        %wspo³rzêdne reki
        %ramie
        d1 = 0.51 * dl_ramienia;
        m1 = 0.026;
        %przedramie
        d2 = 0.39 * dl_przedramienia;
        m2 = 0.021;
        %d³oñ
        d3 = 0.48 * dl_dloni;
        m3 = 0.007;
        %wspo³rzêdne g³owy
        dg = 0.47 * dl_glowy;
        mg = 0.07;
        %wspolrzedne nogi
        %udo
        d11 = 0.37 * dl_uda;
        m11 = 0.1;
        %podudzie
        d22 = 0.37 * dl_podudzia;
        m22 = 0.04;
        %stopa
        d33 = 0.45 * dl_stopy;
        m33 = 0.02;
        % wspolrzedne tu³owia
        dt = 0.38* dl_tulowia;
        mt = 0.51;
          
        %obliczanie wspolrzednych. Pierwszy punkt to baza wzgledem ktorej
        %sie wylicza srodek
          [xsg, zsg] = WyznaczSrodek(Punkty{1},Punkty{2}, dg, dl_glowy);%glowa
          TrajektorieSrodkow{1} = [xsg, zsg];
          [xram, zram] = WyznaczSrodek(Punkty{2},Punkty{3}, d1, dl_ramienia);%ramie
          TrajektorieSrodkow{2} = [xram, zram];
          [xpram, zpram] =  WyznaczSrodek(Punkty{3},Punkty{4}, d2, dl_przedramienia);%przedramie
          TrajektorieSrodkow{3} =  [xpram, zpram];
          [xdloni, zdloni] = WyznaczSrodek(Punkty{4},Punkty{5}, d3, dl_dloni);%dlon
          TrajektorieSrodkow{4} = [xdloni, zdloni];
          [xst, zst] = WyznaczSrodek(Punkty{2},Punkty{6}, dt, dl_tulowia);%tlow
          TrajektorieSrodkow{5} = [xst, zst];
          [xuda, zuda] = WyznaczSrodek(Punkty{6},Punkty{7}, d11, dl_uda);%udo
          TrajektorieSrodkow{6} = [xuda, zuda];
          [xpudzia, zpudzia] = WyznaczSrodek(Punkty{7},Punkty{8}, d22, dl_podudzia);%podudzie
          TrajektorieSrodkow{7} =[xpudzia, zpudzia] ;
          [xstopy, zstopy] =  WyznaczSrodek(Punkty{9},Punkty{10}, d33, dl_stopy);%stopa
          TrajektorieSrodkow{8} = [xstopy, zstopy];
            
          %caly srodek masy
          xc = (xram * m1 + xpram * m2 + xdloni * m3 + xsg * mg + xuda * m11+ xpudzia * m22+ xstopy * m33 + xst*mt) / ((m1+m2+m3)+mg+(m11+m22+m33)+mt);
          zc = (zram * m1 + zpram * m2 + zdloni * m3 + zsg * mg + zuda * m11+ zpudzia * m22+ zstopy * m33 + zst*mt) / ((m1+m2+m3)+mg+(m11+m22+m33)+mt);
          
          TrajektorieSrodkow{9}(1) = xc;%ogolny srodek
          TrajektorieSrodkow{9}(2) = zc;

end
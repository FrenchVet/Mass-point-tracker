function TrajektorieSrodkow =  WyznaczSrodkiCiezkosci(Sciezki, dlugosc)
    
    TrajektorieSrodkow = cell(9,1);%inicjalizacja i zainicjowanie srodkow jako sciezki
    for i = 1:9
        TrajektorieSrodkow{i} = Sciezki{i};
    end

    for i=1:dlugosc%dla kazdej ramki osobno
        
        % Potrzebne dane:
        dl_ramienia = OdlegloscPunktow(Sciezki{2}(i,:),Sciezki{3}(i,:));
        dl_przedramienia = OdlegloscPunktow(Sciezki{3}(i,:),Sciezki{4}(i,:));
        dl_dloni = OdlegloscPunktow(Sciezki{4}(i,:),Sciezki{5}(i,:));
        dl_glowy = OdlegloscPunktow(Sciezki{1}(i,:),Sciezki{2}(i,:));
        dl_uda = OdlegloscPunktow(Sciezki{6}(i,:),Sciezki{7}(i,:));
        dl_podudzia = OdlegloscPunktow(Sciezki{7}(i,:),Sciezki{8}(i,:));
        dl_stopy = OdlegloscPunktow(Sciezki{9}(i,:),Sciezki{10}(i,:));
        dl_tulowia = OdlegloscPunktow(Sciezki{2}(i,:),Sciezki{6}(i,:));
          
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
          [xsg, zsg] = WyznaczSrodek(Sciezki{1}(i,:),Sciezki{2}(i,:), dg, dl_glowy);%glowa
          TrajektorieSrodkow{1}(i,:) = [xsg, zsg];
          [xram, zram] = WyznaczSrodek(Sciezki{2}(i,:),Sciezki{3}(i,:), d1, dl_ramienia);%ramie
          TrajektorieSrodkow{2}(i,:) = [xram, zram];
          [xpram, zpram] =  WyznaczSrodek(Sciezki{3}(i,:),Sciezki{4}(i,:), d2, dl_przedramienia);%przedramie
          TrajektorieSrodkow{3}(i,:) =  [xpram, zpram];
          [xdloni, zdloni] = WyznaczSrodek(Sciezki{4}(i,:),Sciezki{5}(i,:), d3, dl_dloni);%dlon
          TrajektorieSrodkow{4}(i,:) = [xdloni, zdloni];
          [xst, zst] = WyznaczSrodek(Sciezki{2}(i,:),Sciezki{6}(i,:), dt, dl_tulowia);%tlow
          TrajektorieSrodkow{5}(i,:) = [xst, zst];
          [xuda, zuda] = WyznaczSrodek(Sciezki{6}(i,:),Sciezki{7}(i,:), d11, dl_uda);%udo
          TrajektorieSrodkow{6}(i,:) = [xuda, zuda];
          [xpudzia, zpudzia] = WyznaczSrodek(Sciezki{7}(i,:),Sciezki{8}(i,:), d22, dl_podudzia);%podudzie
          TrajektorieSrodkow{7}(i,:) =[xpudzia, zpudzia] ;
          [xstopy, zstopy] =  WyznaczSrodek(Sciezki{9}(i,:),Sciezki{10}(i,:), d33, dl_stopy);%stopa
          TrajektorieSrodkow{8}(i,:) = [xstopy, zstopy];
            
            %caly srodek masy
          xc = (xram * m1 + xpram * m2 + xdloni * m3 + xsg * mg + xuda * m11+ xpudzia * m22+ xstopy * m33 + xst*mt) / ((m1+m2+m3)+mg+(m11+m22+m33)+mt);
          zc = (zram * m1 + zpram * m2 + zdloni * m3 + zsg * mg + zuda * m11+ zpudzia * m22+ zstopy * m33 + zst*mt) / ((m1+m2+m3)+mg+(m11+m22+m33)+mt);
          
          TrajektorieSrodkow{9}(i,1) = xc;%ogolny srodek
          TrajektorieSrodkow{9}(i,2) = zc;
 
    end
end
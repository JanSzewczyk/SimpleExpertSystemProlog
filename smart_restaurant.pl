:- dynamic zamowienia_z/2.
:- dynamic data/2.
%data(null,0).
%zamowienia_z(data(null,0),0).


start:-write('-------------------------------\n'),
      write('RESTAURACJA'), menu.

menu:-nl, write('-------------------------------\n'),
      write('Menu: [pamietaj o kropce]'),nl,
      write('1. Menu zup.'),nl,
      write('2. Menu drugich da�.'),nl,
      write('3. Znajdz wymarzona zupe.'),nl,
      write('4. Znajdz wymarzone drugie danie.'),nl,
      write('5. Sprawdz swoje zam�wienie.'),nl,
      write('6. Drukuj rachunek.'),nl,
      write('7. Koniec.'),nl,
      write('-------------------------------\n'), nl,
      czytaj.




czytaj:-read(R), ((R==1,wyswietl_menu_zup); (R==2,wyswietl_menu_drugich); (R==3,znajdz_zupe); (R==5,sprawdz_zamowienie); (R==6,zapisz_plik); (R==7,koniec)).

%wy�wietlanie wszystkich zup
wyswietl_menu_zup :- nl, write('NASZE ZUPY <3 :\n'),
    (
       nazwa_z(X,Y),write('==>Nazwa: zupa '),write(X),write('t\t\t Cena:  '),write(Y), nl,
       zupa(X,Skladnik), write('\tSk�adnik: '), write(Skladnik);
       menu
    ),
    nl,fail.

%wy�wietlanie wszystkich drugich da�
wyswietl_menu_drugich :- nl, write('NASZE DRUGIE DANIA <3 :\n'),
    (
       nazwa_d(X,Y),write('==>Nazwa: '),write(X),write('t\t\t  Cena:  '),write(Y), nl,
       drugie(X,Skladnik), write('\t Sk�adnik: '), write(Skladnik);
       menu
    ),
    nl,fail.

%wyszukiwanie zupy
znajdz_zupe :- nl, write('ZNAJDZ WYMARZONA ZUPE\n'),
    write('Podaj nazwy skladnikow : '), nl,
    write('1. '), read(Y),
    write('2. '), read(Z),
    (
        (
             (   not(zupa(_,Y)), write('Brak 1. produktu.'), nl, menu);
             (   not(zupa(_,Z)), write('Brak 2. produktu.'), nl, menu)
         );
         true
     ),
     (
         (
             not((zupa(X,Y),zupa(X,Z))),write('Niestety mnie odnalaz�em Twojej wymarzonej zupy :( .'),nl,menu
         );
        true
     ),
     (zupa(X,Y),zupa(X,Z)),(nazwa_z(X,D)),
     write('TWOJA wymarzona zupa to: zupa '),write(X),write('       cena: '),write(D),
     (
          nl, nl, write('Wybierz : '),nl,
          write('1. Dodaj zam�wienie.'), nl,
          write('2. Odrzu� zam�wienie i wr�� do menu.'), nl,
          read(Wyb),
          (
               (Wyb==1,  (write('Wpisz ilo�� posi�k�w (ilo�� > 0) :'), read(Count),
                         %(Count=<0 ,write('Ilo�� nie mo�e by� mniejsza od 0.'),menu);                                %co� sie pie###li
                         asserta(zamowienia_z(data(X,D),Count)),
                         asserta(data(X,D)),
                         write('Dodano do zam�wienia.')),nl, menu );
               (Wyb==2,  (   write(' :( Mo�e nast�pnym razem.')), menu )

          )
     ).

sprawdz_zamowienie :- nl,write('TWOJE zam�wienie :\n'),
    (
         zamowienia_z(data(X,Y),Z),
         write('Nazwa: zupa '),write(X), write('    Cena: '), write(Y), write('    Sztuk: '), write(Z) ,write('    Suma: '),Suma is Y*Z, write(Suma);
         menu
     ),
     nl,fail.

zapisz_plik :- write('Dzi�kuje za z�o�one zam�wienie.'), nl, write('Tw�j rachunek jest zapisany.'), nl, write('Mi�ego dnia ;)'),
     tell('rachunek.txt'),
     (
         zamowienia_z(data(X,Y),Z),
         write('Nazwa: zupa '),write(X), write('    Cena: '), write(Y), write('    Sztuk: '), write(Z),
         write('    Suma: '),Suma is Y*Z, write(Suma), nl
     );
     nl, write('Do zap�acenia : '),
     told,
     nl, write('Tw�j rachunek zosta� wydrukowany'), menu.

koniec:-false.                               %halt


%BAZA WIEDZY zup%

nazwa_z(og�rkowa, 5.00).
nazwa_z(ros�, 5.50).
nazwa_z(kapu�niak, 4.00).
nazwa_z(krupnik, 4.50).
nazwa_z(�urek, 7.00).
nazwa_z(seczu�ska, 5.50).
nazwa_z(kwa�nica, 4.00).
nazwa_z(kr�lewska, 8.00).
nazwa_z(barszcz_ukrai�ski, 5.50).
nazwa_z(z_cukini_z_twarogiem, 4.50).
nazwa_z(broku�owa, 5.50).
nazwa_z(je�ynowa_z_papryk�, 4.50).
nazwa_z(pomidorowa, 3.50).

zupa(og�rkowa,og�rki).
zupa(og�rkowa,ry�).
zupa(og�rkowa,ziemniaki).
zupa(og�rkowa,seler).
zupa(og�rkowa,kurczak).

zupa(ros�,makaron).
zupa(ros�,marchewka).
zupa(ros�,pietruszka).
zupa(ros�,cebula).
zupa(ros�,kurczak).

zupa(kapu�niak,kapusta).
zupa(kapu�niak,boczek).
zupa(kapu�niak,marchewka).
zupa(kapu�niak,ziemniaki).

zupa(pomidorowa,pomidory).
zupa(pomidorowa,makaron).
zupa(pomidorowa,cebula).

zupa(krupnik,kasza_j�czmienna).
zupa(krupnik,marchewka).
zupa(krupnik,por).
zupa(krupnik,ziemniaki).

zupa(�urek,wieprzowina).
zupa(�urek,kie�basa).
zupa(�urek,boczek).
zupa(�urek,jajko).
zupa(�urek,grzyby).

zupa(seczu�ska,wieprzowina).
zupa(seczu�ska,makaron_ry�owy).
zupa(seczu�ska,kapusta_peki�ska).
zupa(seczu�ska,grzyby_Mun).

zupa(kwa�nica,�eberka).
zupa(kwa�nica,s�onina).
zupa(kwa�nica,kapusta).
zupa(kwa�nica,marchewka).

zupa(kr�lewska,kurczak).
zupa(kr�lewska,por).
zupa(kr�lewska,seler).
zupa(kr�lewska,groszek_ptysiowy).

zupa(barszcz_ukrai�ski,fasola).
zupa(barszcz_ukrai�ski,zimniaki).
zupa(barszcz_ukrai�ski,buraki).

zupa(z_cukini_z_twarogiem,cukinia).
zupa(z_cukini_z_twarogiem,chrzan).
zupa(z_cukini_z_twarogiem,ser).
zupa(z_cukini_z_twarogiem,jajko).
zupa(z_cukini_z_twarogiem,twar�g).

zupa(broku�owa,broku�y).
zupa(broku�owa,parmezan).
zupa(broku�owa,seler).
zupa(broku�owa,ziemniaki).

zupa(je�ynowa_z_papryk�,papryka).
zupa(je�ynowa_z_papryk�,ketchup).
zupa(je�ynowa_z_papryk�,groszek).
zupa(je�ynowa_z_papryk�,cebula).

zupa(paprykowa_z_pulpetami,wieprzowina).
zupa(paprykowa_z_pulpetami,papryka).
zupa(paprykowa_z_pulpetami,czosnek).
zupa(paprykowa_z_pulpetami,chili).


%BAZA WIEDZY drugie danie.%
nazwa_d(mi�so_mielone_z_cukini�,10.00).
nazwa_d(rigatoni_z_pomidorami,12.50).
nazwa_d(penne_z_kurczakiem_i_krewetkami,18.00).
nazwa_d(sa�atka_z_kurczakiem,11.00).
nazwa_d(klopsiki_w_sosie_pomidorowym,13.00).
nazwa_d(faszerowana_cukinia,14.00).
nazwa_d(go��bki,10.00).
nazwa_d(pikantna_sa�atka_meksyka�ska,12.50).
nazwa_d(pomidory_faszerowane_miesem_mielonym,15.00).
nazwa_d(pomidory_faszerowane,11.00).
nazwa_d(faszerowana_papryka,10.00).
nazwa_d(makaron_4_sery,13.70).
nazwa_d(makaron_po_bolo�sku,17.00).
nazwa_d(piecze�_wielkanocna,15.50).
nazwa_d(w�oskie_szasz�yki,19.00).
nazwa_d(zapiekanka_makaronowa_z_dyni�,13.80).
nazwa_d(lopsy_w_sosie_borowikowym,20.99).

drugie(mi�so_mielone_z_cukini�,wo�owina).
drugie(mi�so_mielone_z_cukini�,cebula).
drugie(mi�so_mielone_z_cukini�,cukinia).
drugie(mi�so_mielone_z_cukini�,ry�).

drugie(rigatoni_z_pomidorami,makaron).
drugie(rigatoni_z_pomidorami,pomidory).
drugie(rigatoni_z_pomidorami,mozzarella).

drugie(penne_z_kurczakiem_i_krewetkami,penne).
drugie(penne_z_kurczakiem_i_krewetkami,krewetki).
drugie(penne_z_kurczakiem_i_krewetkami,kurczak).
drugie(penne_z_kurczakiem_i_krewetkami,musztarda).
drugie(penne_z_kurczakiem_i_krewetkami,pomidory).

drugie(sa�atka_z_kurczakiem,ry�).
drugie(sa�atka_z_kurczakiem,seler).
drugie(sa�atka_z_kurczakiem,papryka).
drugie(sa�atka_z_kurczakiem,kurczak).
drugie(sa�atka_z_kurczakiem,kasztany).

drugie(klopsiki_w_sosie_pomidorowym,indyk).
drugie(klopsiki_w_sosie_pomidorowym,papryka).
drugie(klopsiki_w_sosie_pomidorowym,cukinia).
drugie(klopsiki_w_sosie_pomidorowym,pomidory).

drugie(faszerowana_cukinia,cukinia).
drugie(faszerowana_cukinia,wo�owina).
drugie(faszerowana_cukinia,ry�).
drugie(faszerowana_cukinia,pomidory).
drugie(faszerowana_cukinia,cukinia).

drugie(go��bki,kapusta).
drugie(go��bki,wiprzowina).
drugie(go��bki,ry�).
drugie(go��bki,komidory).

drugie(pikantna_sa�atka_meksyka�ska, kurczak).
drugie(pikantna_sa�atka_meksyka�ska, ry�).
drugie(pikantna_sa�atka_meksyka�ska, fasola).
drugie(pikantna_sa�atka_meksyka�ska, kukurydza).

drugie(pomidory_faszerowane_miesem_mielonym,ry�).
drugie(pomidory_faszerowane_miesem_mielonym,wieprzowina).
drugie(pomidory_faszerowane_miesem_mielonym,pomidory).
drugie(pomidory_faszerowane_miesem_mielonym,mozzarella).

drugie(pomidory_faszerowane,pomidory).
drugie(pomidory_faszerowane,kurczak).
drugie(pomidory_faszerowane,ry�).
drugie(pomidory_faszerowane,cebula).

drugie(faszerowana_papryka,wo�owina).
drugie(faszerowana_papryka,wieprzowina).
drugie(faszerowana_papryka,papryka).
drugie(faszerowana_papryka,ry�).
drugie(faszerowana_papryka,cebula).

drugie(makaron_4_sery,ser).
drugie(makaron_4_sery,brie).
drugie(makaron_4_sery,ementaler).
drugie(makaron_4_sery,makaron).
drugie(makaron_4_sery,parmezan).

drugie(makaron_po_bolo�sku,wieprzowina).
drugie(makaron_po_bolo�sku,makaron).
drugie(makaron_po_bolo�sku,marchewka).
drugie(makaron_po_bolo�sku,pomidory).
drugie(makaron_po_bolo�sku,wo�owina).
drugie(makaron_po_bolo�sku,parmezan).

drugie(piecze�_wielkanocna,grzyby).
drugie(piecze�_wielkanocna,wieprzowina).
drugie(piecze�_wielkanocna,wo�owina).
drugie(piecze�_wielkanocna,jajka).
drugie(piecze�_wielkanocna,�liwki).

drugie(w�oskie_szasz�yki,papryka).
drugie(w�oskie_szasz�yki,pieczarki).
drugie(w�oskie_szasz�yki,pomidory).
drugie(w�oskie_szasz�yki,papryka).

drugie(zapiekanka_makaronowa_z_dyni�,makaron).
drugie(zapiekanka_makaronowa_z_dyni�,wieprzowina).
drugie(zapiekanka_makaronowa_z_dyni�,dynia).
drugie(zapiekanka_makaronowa_z_dyni�,cebula).
drugie(zapiekanka_makaronowa_z_dyni�,ser_��ty).

drugie(lopsy_w_sosie_borowikowym,wieprzowina).
drugie(lopsy_w_sosie_borowikowym,czosnek).
drugie(lopsy_w_sosie_borowikowym,jajko).
drugie(lopsy_w_sosie_borowikowym,cebula).




















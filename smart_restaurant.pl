:- dynamic zamowienia_z/2.
:- dynamic data/2.
%data(null,0).
%zamowienia_z(data(null,0),0).


start:-write('-------------------------------\n'),
      write('RESTAURACJA'), menu.

menu:-nl, write('-------------------------------\n'),
      write('Menu: [pamietaj o kropce]'),nl,
      write('1. Menu zup.'),nl,
      write('2. Menu drugich dañ.'),nl,
      write('3. Znajdz wymarzona zupe.'),nl,
      write('4. Znajdz wymarzone drugie danie.'),nl,
      write('5. Sprawdz swoje zamówienie.'),nl,
      write('6. Drukuj rachunek.'),nl,
      write('7. Koniec.'),nl,
      write('-------------------------------\n'), nl,
      czytaj.




czytaj:-read(R), ((R==1,wyswietl_menu_zup); (R==2,wyswietl_menu_drugich); (R==3,znajdz_zupe); (R==5,sprawdz_zamowienie); (R==6,zapisz_plik); (R==7,koniec)).

%wyœwietlanie wszystkich zup
wyswietl_menu_zup :- nl, write('NASZE ZUPY <3 :\n'),
    (
       nazwa_z(X,Y),write('==>Nazwa: zupa '),write(X),write('t\t\t Cena:  '),write(Y), nl,
       zupa(X,Skladnik), write('\tSk³adnik: '), write(Skladnik);
       menu
    ),
    nl,fail.

%wyœwietlanie wszystkich drugich dañ
wyswietl_menu_drugich :- nl, write('NASZE DRUGIE DANIA <3 :\n'),
    (
       nazwa_d(X,Y),write('==>Nazwa: '),write(X),write('t\t\t  Cena:  '),write(Y), nl,
       drugie(X,Skladnik), write('\t Sk³adnik: '), write(Skladnik);
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
             not((zupa(X,Y),zupa(X,Z))),write('Niestety mnie odnalaz³em Twojej wymarzonej zupy :( .'),nl,menu
         );
        true
     ),
     (zupa(X,Y),zupa(X,Z)),(nazwa_z(X,D)),
     write('TWOJA wymarzona zupa to: zupa '),write(X),write('       cena: '),write(D),
     (
          nl, nl, write('Wybierz : '),nl,
          write('1. Dodaj zamówienie.'), nl,
          write('2. Odrzuæ zamówienie i wróæ do menu.'), nl,
          read(Wyb),
          (
               (Wyb==1,  (write('Wpisz iloœæ posi³ków (iloœæ > 0) :'), read(Count),
                         %(Count=<0 ,write('Iloœæ nie mo¿e byæ mniejsza od 0.'),menu);                                %coœ sie pie###li
                         asserta(zamowienia_z(data(X,D),Count)),
                         asserta(data(X,D)),
                         write('Dodano do zamówienia.')),nl, menu );
               (Wyb==2,  (   write(' :( Mo¿e nastêpnym razem.')), menu )

          )
     ).

sprawdz_zamowienie :- nl,write('TWOJE zamówienie :\n'),
    (
         zamowienia_z(data(X,Y),Z),
         write('Nazwa: zupa '),write(X), write('    Cena: '), write(Y), write('    Sztuk: '), write(Z) ,write('    Suma: '),Suma is Y*Z, write(Suma);
         menu
     ),
     nl,fail.

zapisz_plik :- write('Dziêkuje za z³o¿one zamówienie.'), nl, write('Twój rachunek jest zapisany.'), nl, write('Mi³ego dnia ;)'),
     tell('rachunek.txt'),
     (
         zamowienia_z(data(X,Y),Z),
         write('Nazwa: zupa '),write(X), write('    Cena: '), write(Y), write('    Sztuk: '), write(Z),
         write('    Suma: '),Suma is Y*Z, write(Suma), nl
     );
     nl, write('Do zap³acenia : '),
     told,
     nl, write('Twój rachunek zosta³ wydrukowany'), menu.

koniec:-false.                               %halt


%BAZA WIEDZY zup%

nazwa_z(ogórkowa, 5.00).
nazwa_z(rosó³, 5.50).
nazwa_z(kapuœniak, 4.00).
nazwa_z(krupnik, 4.50).
nazwa_z(¿urek, 7.00).
nazwa_z(seczuñska, 5.50).
nazwa_z(kwaœnica, 4.00).
nazwa_z(królewska, 8.00).
nazwa_z(barszcz_ukraiñski, 5.50).
nazwa_z(z_cukini_z_twarogiem, 4.50).
nazwa_z(broku³owa, 5.50).
nazwa_z(je¿ynowa_z_papryk¹, 4.50).
nazwa_z(pomidorowa, 3.50).

zupa(ogórkowa,ogórki).
zupa(ogórkowa,ry¿).
zupa(ogórkowa,ziemniaki).
zupa(ogórkowa,seler).
zupa(ogórkowa,kurczak).

zupa(rosó³,makaron).
zupa(rosó³,marchewka).
zupa(rosó³,pietruszka).
zupa(rosó³,cebula).
zupa(rosó³,kurczak).

zupa(kapuœniak,kapusta).
zupa(kapuœniak,boczek).
zupa(kapuœniak,marchewka).
zupa(kapuœniak,ziemniaki).

zupa(pomidorowa,pomidory).
zupa(pomidorowa,makaron).
zupa(pomidorowa,cebula).

zupa(krupnik,kasza_jêczmienna).
zupa(krupnik,marchewka).
zupa(krupnik,por).
zupa(krupnik,ziemniaki).

zupa(¿urek,wieprzowina).
zupa(¿urek,kie³basa).
zupa(¿urek,boczek).
zupa(¿urek,jajko).
zupa(¿urek,grzyby).

zupa(seczuñska,wieprzowina).
zupa(seczuñska,makaron_ry¿owy).
zupa(seczuñska,kapusta_pekiñska).
zupa(seczuñska,grzyby_Mun).

zupa(kwaœnica,¿eberka).
zupa(kwaœnica,s³onina).
zupa(kwaœnica,kapusta).
zupa(kwaœnica,marchewka).

zupa(królewska,kurczak).
zupa(królewska,por).
zupa(królewska,seler).
zupa(królewska,groszek_ptysiowy).

zupa(barszcz_ukraiñski,fasola).
zupa(barszcz_ukraiñski,zimniaki).
zupa(barszcz_ukraiñski,buraki).

zupa(z_cukini_z_twarogiem,cukinia).
zupa(z_cukini_z_twarogiem,chrzan).
zupa(z_cukini_z_twarogiem,ser).
zupa(z_cukini_z_twarogiem,jajko).
zupa(z_cukini_z_twarogiem,twaróg).

zupa(broku³owa,broku³y).
zupa(broku³owa,parmezan).
zupa(broku³owa,seler).
zupa(broku³owa,ziemniaki).

zupa(je¿ynowa_z_papryk¹,papryka).
zupa(je¿ynowa_z_papryk¹,ketchup).
zupa(je¿ynowa_z_papryk¹,groszek).
zupa(je¿ynowa_z_papryk¹,cebula).

zupa(paprykowa_z_pulpetami,wieprzowina).
zupa(paprykowa_z_pulpetami,papryka).
zupa(paprykowa_z_pulpetami,czosnek).
zupa(paprykowa_z_pulpetami,chili).


%BAZA WIEDZY drugie danie.%
nazwa_d(miêso_mielone_z_cukini¹,10.00).
nazwa_d(rigatoni_z_pomidorami,12.50).
nazwa_d(penne_z_kurczakiem_i_krewetkami,18.00).
nazwa_d(sa³atka_z_kurczakiem,11.00).
nazwa_d(klopsiki_w_sosie_pomidorowym,13.00).
nazwa_d(faszerowana_cukinia,14.00).
nazwa_d(go³¹bki,10.00).
nazwa_d(pikantna_sa³atka_meksykañska,12.50).
nazwa_d(pomidory_faszerowane_miesem_mielonym,15.00).
nazwa_d(pomidory_faszerowane,11.00).
nazwa_d(faszerowana_papryka,10.00).
nazwa_d(makaron_4_sery,13.70).
nazwa_d(makaron_po_boloñsku,17.00).
nazwa_d(pieczeñ_wielkanocna,15.50).
nazwa_d(w³oskie_szasz³yki,19.00).
nazwa_d(zapiekanka_makaronowa_z_dyni¹,13.80).
nazwa_d(lopsy_w_sosie_borowikowym,20.99).

drugie(miêso_mielone_z_cukini¹,wo³owina).
drugie(miêso_mielone_z_cukini¹,cebula).
drugie(miêso_mielone_z_cukini¹,cukinia).
drugie(miêso_mielone_z_cukini¹,ry¿).

drugie(rigatoni_z_pomidorami,makaron).
drugie(rigatoni_z_pomidorami,pomidory).
drugie(rigatoni_z_pomidorami,mozzarella).

drugie(penne_z_kurczakiem_i_krewetkami,penne).
drugie(penne_z_kurczakiem_i_krewetkami,krewetki).
drugie(penne_z_kurczakiem_i_krewetkami,kurczak).
drugie(penne_z_kurczakiem_i_krewetkami,musztarda).
drugie(penne_z_kurczakiem_i_krewetkami,pomidory).

drugie(sa³atka_z_kurczakiem,ry¿).
drugie(sa³atka_z_kurczakiem,seler).
drugie(sa³atka_z_kurczakiem,papryka).
drugie(sa³atka_z_kurczakiem,kurczak).
drugie(sa³atka_z_kurczakiem,kasztany).

drugie(klopsiki_w_sosie_pomidorowym,indyk).
drugie(klopsiki_w_sosie_pomidorowym,papryka).
drugie(klopsiki_w_sosie_pomidorowym,cukinia).
drugie(klopsiki_w_sosie_pomidorowym,pomidory).

drugie(faszerowana_cukinia,cukinia).
drugie(faszerowana_cukinia,wo³owina).
drugie(faszerowana_cukinia,ry¿).
drugie(faszerowana_cukinia,pomidory).
drugie(faszerowana_cukinia,cukinia).

drugie(go³¹bki,kapusta).
drugie(go³¹bki,wiprzowina).
drugie(go³¹bki,ry¿).
drugie(go³¹bki,komidory).

drugie(pikantna_sa³atka_meksykañska, kurczak).
drugie(pikantna_sa³atka_meksykañska, ry¿).
drugie(pikantna_sa³atka_meksykañska, fasola).
drugie(pikantna_sa³atka_meksykañska, kukurydza).

drugie(pomidory_faszerowane_miesem_mielonym,ry¿).
drugie(pomidory_faszerowane_miesem_mielonym,wieprzowina).
drugie(pomidory_faszerowane_miesem_mielonym,pomidory).
drugie(pomidory_faszerowane_miesem_mielonym,mozzarella).

drugie(pomidory_faszerowane,pomidory).
drugie(pomidory_faszerowane,kurczak).
drugie(pomidory_faszerowane,ry¿).
drugie(pomidory_faszerowane,cebula).

drugie(faszerowana_papryka,wo³owina).
drugie(faszerowana_papryka,wieprzowina).
drugie(faszerowana_papryka,papryka).
drugie(faszerowana_papryka,ry¿).
drugie(faszerowana_papryka,cebula).

drugie(makaron_4_sery,ser).
drugie(makaron_4_sery,brie).
drugie(makaron_4_sery,ementaler).
drugie(makaron_4_sery,makaron).
drugie(makaron_4_sery,parmezan).

drugie(makaron_po_boloñsku,wieprzowina).
drugie(makaron_po_boloñsku,makaron).
drugie(makaron_po_boloñsku,marchewka).
drugie(makaron_po_boloñsku,pomidory).
drugie(makaron_po_boloñsku,wo³owina).
drugie(makaron_po_boloñsku,parmezan).

drugie(pieczeñ_wielkanocna,grzyby).
drugie(pieczeñ_wielkanocna,wieprzowina).
drugie(pieczeñ_wielkanocna,wo³owina).
drugie(pieczeñ_wielkanocna,jajka).
drugie(pieczeñ_wielkanocna,œliwki).

drugie(w³oskie_szasz³yki,papryka).
drugie(w³oskie_szasz³yki,pieczarki).
drugie(w³oskie_szasz³yki,pomidory).
drugie(w³oskie_szasz³yki,papryka).

drugie(zapiekanka_makaronowa_z_dyni¹,makaron).
drugie(zapiekanka_makaronowa_z_dyni¹,wieprzowina).
drugie(zapiekanka_makaronowa_z_dyni¹,dynia).
drugie(zapiekanka_makaronowa_z_dyni¹,cebula).
drugie(zapiekanka_makaronowa_z_dyni¹,ser_¿ó³ty).

drugie(lopsy_w_sosie_borowikowym,wieprzowina).
drugie(lopsy_w_sosie_borowikowym,czosnek).
drugie(lopsy_w_sosie_borowikowym,jajko).
drugie(lopsy_w_sosie_borowikowym,cebula).




















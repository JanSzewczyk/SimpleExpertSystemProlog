:- dynamic zamowienia_z/2.
:- dynamic data/2.
:- dynamic zamowienia_d/2.
%
%data(null,0).
%zamowienia_z(data(null,0),0).

:-( clause(nazwa_z(_,_),_) ; clause(zupa(_,_),_) ; clause(drugie(_,_),_) ; clause(nazwa_d(_,_),_) ; consult('food_kb.pl')).

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


czytaj:-read(R), ((R==1,wyswietl_menu_zup); (R==2,wyswietl_menu_glownych); (R==3,znajdz_zupe); (R==4,znajdz_drugie); (R==5,sprawdz_zamowienie); (R==6,zapisz_plik); (R==7,koniec)).

%wy�wietlanie wszystkich zup
wyswietl_menu_zup :- nl, write('NASZE ZUPY <3 :\n'),
    (
       nazwa_z(X,Y),write('==>Nazwa: zupa '),write(X),write('t\t\t Cena:  '),write(Y), nl,
       zupa(X,Skladnik), write('\tSk�adnik: '), write(Skladnik);
       menu
    ),
    nl,fail.

%wy�wietlanie wszystkich gl�wnych da�
wyswietl_menu_glownych :- nl, write('NASZE DRUGIE DANIA <3 :\n'),
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

%wyszukiwanie dania g��wnego
znajdz_drugie :- nl, write('ZNAJDZ WYMARZONE DANIE G��WNE :\n'),
    write('Podaj nazwy skladnikow : '), nl,
    write('1. '), read(Y),
    write('2. '), read(Z),
    (
        (
             (   not(drugie(_,Y)), write('Brak 1. produktu.'), nl, menu);
             (   not(drugie(_,Z)), write('Brak 2. produktu.'), nl, menu)
         );
         true
     ),
     (
         (
             not((drugie(X,Y),drugie(X,Z))),write('Niestety mnie odnalaz�em Twojego wymarzonego dania g��wnego :( .'),nl,menu
         );
        true
     ),
     (drugie(X,Y),drugie(X,Z)),(nazwa_d(X,D)),
     write('TWOJE wymarzone danie to: '),write(X),write('       cena: '),write(D),
     (
          nl, nl, write('Wybierz : '),nl,
          write('1. Dodaj zam�wienie.'), nl,
          write('2. Odrzu� zam�wienie i wr�� do menu.'), nl,
          read(Wyb),
          (
               (Wyb==1,  (write('Wpisz ilo�� posi�k�w (ilo�� > 0) :'), read(Count),
                         %(Count=<0 ,write('Ilo�� nie mo�e by� mniejsza od 0.'),menu);                                %co� sie pie###li
                         asserta(zamowienia_d(data(X,D),Count)),
                         asserta(data(X,D)),
                         write('Dodano do zam�wienia.')),nl, menu );
+               (Wyb==2,  (   write(' :( Mo�e nast�pnym razem.')), menu )

          )
     ).

%Wy�wietlanie zam�wie�
sprawdz_zamowienie :- nl,write('TWOJE zam�wienie :\n'),
    (
         write('=>Zupy :'),nl,
         zamowienia_z(data(X,Y),Z),
         write('\tNazwa: zupa '),write(X), write('\tCena: '), write(Y), write('\tSztuk: '), write(Z) ,write('\tSuma: '),Suma is Y*Z, write(Suma);
         write('=>Danie g��wne :'),nl,
         zamowienia_d(data(X1,Y1),Z1),
         write('\tNazwa: '),write(X1), write('\tCena: '), write(Y1), write('\tSztuk: '), write(Z1) ,write('\tSuma: '),Suma is Y1*Z1, write(Suma);
         menu
     ),
     nl,fail.

%Zapisanie zam�wienia do pliku
zapisz_plik :- write('\nDzi�kuje za z�o�one zam�wienie.'), nl, write('Tw�j rachunek jest zapisany.'), nl, write('Mi�ego dnia ;)'), nl,
     tell('rachunek.txt'),
     (
         write('=>Zupy :'),nl,
         zamowienia_z(data(X,Y),Z),
         write('\tNazwa: zupa '),write(X), write('\tCena: '), write(Y), write('\tSztuk: '), write(Z) ,write('\tSuma: '),Suma is Y*Z, write(Suma);
         nl,
         write('=>Danie g��wne :'),nl,
         zamowienia_d(data(X1,Y1),Z1),
         write('\tNazwa: '),write(X1), write('\tCena: '), write(Y1), write('\tSztuk: '), write(Z1) ,write('\tSuma: '),Suma is Y1*Z1, write(Suma)
      );
     nl, write('\tDzi�kuj� za z�o�enie zam�wienia w mojej restauracji !\n\tMi�ego dnia :)'),
     told,
     nl, write('Tw�j rachunek zosta� wydrukowany'), menu.

koniec:-halt.





















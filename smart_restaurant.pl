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
      write('2. Menu drugich dań.'),nl,
      write('3. Znajdz wymarzona zupe.'),nl,
      write('4. Znajdz wymarzone drugie danie.'),nl,
      write('5. Sprawdz swoje zamówienie.'),nl,
      write('6. Drukuj rachunek.'),nl,
      write('7. Koniec.'),nl,
      write('-------------------------------\n'), nl,
      czytaj.


czytaj:-read(R), ((R==1,wyswietl_menu_zup); (R==2,wyswietl_menu_glownych); (R==3,znajdz_zupe); (R==4,znajdz_drugie); (R==5,sprawdz_zamowienie); (R==6,zapisz_plik); (R==7,koniec)).

%wyświetlanie wszystkich zup
wyswietl_menu_zup :- nl, write('NASZE ZUPY <3 :\n'),
    (
       nazwa_z(X,Y),write('==>Nazwa: zupa '),write(X),write('t\t\t Cena:  '),write(Y), nl,
       zupa(X,Skladnik), write('\tSkładnik: '), write(Skladnik);
       menu
    ),
    nl,fail.

%wyświetlanie wszystkich glównych dań
wyswietl_menu_glownych :- nl, write('NASZE DRUGIE DANIA <3 :\n'),
    (
       nazwa_d(X,Y),write('==>Nazwa: '),write(X),write('t\t\t  Cena:  '),write(Y), nl,
       drugie(X,Skladnik), write('\t Składnik: '), write(Skladnik);
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
             not((zupa(X,Y),zupa(X,Z))),write('Niestety mnie odnalazłem Twojej wymarzonej zupy :( .'),nl,menu
         );
        true
     ),
     (zupa(X,Y),zupa(X,Z)),(nazwa_z(X,D)),
     write('TWOJA wymarzona zupa to: zupa '),write(X),write('       cena: '),write(D),
     (
          nl, nl, write('Wybierz : '),nl,
          write('1. Dodaj zamówienie.'), nl,
          write('2. Odrzuć zamówienie i wróć do menu.'), nl,
          read(Wyb),
          (
               (Wyb==1,  (write('Wpisz ilość posiłków (ilość > 0) :'), read(Count),
                         %(Count=<0 ,write('Ilość nie może być mniejsza od 0.'),menu);                               
                         asserta(zamowienia_z(data(X,D),Count)),
                         asserta(data(X,D)),
                         write('Dodano do zamówienia.')),nl, menu );
               (Wyb==2,  (   write(' :( Może następnym razem.')), menu )

          )
     ).

%wyszukiwanie dania głównego
znajdz_drugie :- nl, write('ZNAJDZ WYMARZONE DANIE GŁÓWNE :\n'),
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
             not((drugie(X,Y),drugie(X,Z))),write('Niestety mnie odnalazłem Twojego wymarzonego dania głównego :( .'),nl,menu
         );
        true
     ),
     (drugie(X,Y),drugie(X,Z)),(nazwa_d(X,D)),
     write('TWOJE wymarzone danie to: '),write(X),write('       cena: '),write(D),
     (
          nl, nl, write('Wybierz : '),nl,
          write('1. Dodaj zamówienie.'), nl,
          write('2. Odrzuć zamówienie i wróć do menu.'), nl,
          read(Wyb),
          (
               (Wyb==1,  (write('Wpisz ilość posiłków (ilość > 0) :'), read(Count),
                         %(Count=<0 ,write('Ilość nie może być mniejsza od 0.'),menu);                               
                         asserta(zamowienia_d(data(X,D),Count)),
                         asserta(data(X,D)),
                         write('Dodano do zamówienia.')),nl, menu );
+               (Wyb==2,  (   write(' :( Może następnym razem.')), menu )

          )
     ).

%Wyświetlanie zamówień
sprawdz_zamowienie :- nl,write('TWOJE zamówienie :\n'),
    (
         write('=>Zupy :'),nl,
         zamowienia_z(data(X,Y),Z),
         write('\tNazwa: zupa '),write(X), write('\tCena: '), write(Y), write('\tSztuk: '), write(Z) ,write('\tSuma: '),Suma is Y*Z, write(Suma);
         write('=>Danie główne :'),nl,
         zamowienia_d(data(X1,Y1),Z1),
         write('\tNazwa: '),write(X1), write('\tCena: '), write(Y1), write('\tSztuk: '), write(Z1) ,write('\tSuma: '),Suma is Y1*Z1, write(Suma);
         menu
     ),
     nl,fail.

%Zapisanie zamówienia do pliku
zapisz_plik :- write('\nDziękuje za złożone zamówienie.'), nl, write('Twój rachunek jest zapisany.'), nl, write('Miłego dnia ;)'), nl,
     tell('rachunek.txt'),
     (
         write('=>Zupy :'),nl,
         zamowienia_z(data(X,Y),Z),
         write('\tNazwa: zupa '),write(X), write('\tCena: '), write(Y), write('\tSztuk: '), write(Z) ,write('\tSuma: '),Suma is Y*Z, write(Suma);
         nl,
         write('=>Danie główne :'),nl,
         zamowienia_d(data(X1,Y1),Z1),
         write('\tNazwa: '),write(X1), write('\tCena: '), write(Y1), write('\tSztuk: '), write(Z1) ,write('\tSuma: '),Suma is Y1*Z1, write(Suma)
      );
     nl, write('\tDziękuję za złożenie zamówienia w mojej restauracji !\n\tMiłego dnia :)'),
     told,
     nl, write('Twój rachunek został wydrukowany'), menu.

koniec:-halt.





















:- set_prolog_flag(encoding, utf8).
:- set_stream(user_input, encoding(utf8)).
:- set_stream(user_output, encoding(utf8)).
:- set_stream(user_error, encoding(utf8)).
:- dynamic fact/2.

% Fakty
fact(engine_check_light_on, yes).
fact(strange_noise, yes).
fact(smoke_color, black).
fact(smoke_color, white).
fact(fuel_efficiency, poor).
fact(overheating, yes).
fact(oil_leak, yes).
fact(brake_issue, yes).

% Reguły wnioskowania
diagnosis('Problem z układem paliwowym lub turbosprężarką') :-
    fact(engine_check_light_on, yes),
    fact(smoke_color, black).

diagnosis('Możliwe uszkodzenie uszczelki pod głowicą') :-
    fact(engine_check_light_on, yes),
    fact(smoke_color, white).

diagnosis('Sprawdź układ wydechowy lub zawieszenie') :-
    fact(strange_noise, yes).

diagnosis('Zalecana diagnostyka układu paliwowego') :-
    fact(fuel_efficiency, poor).

diagnosis('Wycieki oleju mogą powodować przegrzewanie się silnika. Sprawdź uszczelki') :-
    fact(overheating, yes),
    fact(oil_leak, yes).

diagnosis('Przegrzewanie silnika. Sprawdź układ chłodzenia') :-
    fact(overheating, yes),
    \+ fact(oil_leak, yes).

diagnosis('Problem z układem hamulcowym. Sprawdź klocki hamulcowe lub płyn hamulcowy') :-
    fact(brake_issue, yes).

diagnosis('Brak jednoznacznej diagnozy. Skontaktuj się z mechanikiem') :-
    \+ diagnosis(_).
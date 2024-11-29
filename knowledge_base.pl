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
diagnosis('Problem z ukladem paliwowym lub turbosprezarka') :-
    fact(engine_check_light_on, yes),
    fact(smoke_color, black).

diagnosis('Mozliwe uszkodzenie uszczelki pod głowica') :-
    fact(engine_check_light_on, yes),
    fact(smoke_color, white).

diagnosis('Sprawdz uklad wydechowy lub zawieszenie') :-
    fact(strange_noise, yes).

diagnosis('Zalecana diagnostyka ukladu paliwowego') :-
    fact(fuel_efficiency, poor).

diagnosis('Wycieki oleju moga powodowac przegrzewanie się silnika. Sprawdz uszczelki') :-
    fact(overheating, yes),
    fact(oil_leak, yes).

diagnosis('Przegrzewanie silnika. Sprawdz uklad chlodzenia') :-
    fact(overheating, yes),
    \+ fact(oil_leak, yes).

diagnosis('Problem z ukladem hamulcowym. Sprawdz klocki hamulcowe lub plyn hamulcowy') :-
    fact(brake_issue, yes).

diagnosis('Brak jednoznacznej diagnozy. Skontaktuj się z mechanikiem') :-
    \+ diagnosis(_).
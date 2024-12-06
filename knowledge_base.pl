:- set_prolog_flag(encoding, utf8).
:- set_stream(user_input, encoding(utf8)).
:- set_stream(user_output, encoding(utf8)).
:- set_stream(user_error, encoding(utf8)).
:- dynamic fact/2.

% === Fakty domyślne ===
fact(engine_check_light_on, no).
fact(strange_noise, no).
fact(smoke_color, none).
fact(fuel_efficiency, good).
fact(overheating, no).
fact(oil_leak, no).
fact(brake_issue, no).
fact(battery_issue, no).
fact(light_issue, no).
fact(vibration_during_drive, no).
fact(power_loss, no).
fact(leaking_fluid, no).
fact(exhaust_smoke, none).
fact(fuel_tank_empty, no).
fact(engine_temperature, 90). % Normalna temperatura silnika
fact(tire_pressure, 32). % Ciśnienie w oponach (psi)
fact(oil_level, 50). % Poziom oleju (skala 0-100)
fact(battery_voltage, 12.5). % Napięcie akumulatora (V)
fact(fuel_consumption, 8). % Zużycie paliwa (L/100km)

% === Progi (stałe) ===
threshold(engine_temperature_high, 100). % Maksymalna bezpieczna temperatura silnika (Celsius)
threshold(tire_pressure_low, 30). % Minimalne ciśnienie w oponach (psi)
threshold(tire_pressure_high, 35). % Maksymalne ciśnienie w oponach (psi)
threshold(oil_level_low, 20). % Minimalny poziom oleju
threshold(oil_level_high, 80). % Maksymalny poziom oleju
threshold(battery_voltage_low, 11.5). % Minimalne napięcie akumulatora (V)
threshold(battery_voltage_high, 14.5). % Maksymalne napięcie akumulatora (V)
threshold(fuel_consumption_high, 15). % Maksymalne zużycie paliwa (L/100km)

% === Walidacja danych ===
valid_oil_level(Level) :- Level >= 0.0, Level =< 100.0.
valid_battery_voltage(Voltage) :- Voltage >= 10.0, Voltage =< 14.5.
valid_tire_pressure(Pressure) :- Pressure >= 20.0, Pressure =< 50.0.
valid_fuel_consumption(Consumption) :- Consumption >= 0.0.
valid_smoke_color(Color) :- member(Color, [none, black, white]).
valid_engine_temperature(Temp) :- Temp >= 0.0.

% === Reguły diagnozy ===
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

diagnosis('Problem z ciśnieniem w oponach. Sprawdź opony') :-
    fact(tire_pressure, Pressure),
    threshold(tire_pressure_low, Min),
    threshold(tire_pressure_high, Max),
    valid_tire_pressure(Pressure),
    (Pressure < Min ; Pressure > Max).

diagnosis('Niski poziom oleju. Uzupełnij olej') :-
    fact(oil_level, Level),
    threshold(oil_level_low, Min),
    valid_oil_level(Level),
    Level < Min.

diagnosis('Problem z akumulatorem. Sprawdź ładowanie') :-
    fact(battery_voltage, Voltage),
    threshold(battery_voltage_low, Min),
    valid_battery_voltage(Voltage),
    Voltage < Min.

diagnosis('Zbyt wysokie zużycie paliwa. Sprawdź wtryski lub mieszankę paliwową') :-
    fact(fuel_consumption, Consumption),
    threshold(fuel_consumption_high, Limit),
    valid_fuel_consumption(Consumption),
    Consumption > Limit.

diagnosis('Przegrzewanie silnika. Sprawdź termostat lub układ chłodzenia') :-
    fact(engine_temperature, Temp),
    threshold(engine_temperature_high, Limit),
    valid_engine_temperature(Temp),
    Temp > Limit.

% Jeśli żadna z reguł nie pasuje
diagnosis('Brak jednoznacznej diagnozy. Skontaktuj się z mechanikiem.') :-
    \+ diagnosis(_).
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
fact(tire_pressure, 32). % Ciśnienie w oponach (psi)
fact(oil_level, 50). % Poziom oleju (skala 0-100)
fact(battery_voltage, 12.5). % Napięcie akumulatora (V)
fact(fuel_consumption, 8). % Zużycie paliwa (L/100km)

% === Progi (stałe) ===
threshold(tire_pressure_low, 30). % Minimalne ciśnienie w oponach (psi)
threshold(tire_pressure_high, 35). % Maksymalne ciśnienie w oponach (psi)
threshold(oil_level_low, 20). % Minimalny poziom oleju
threshold(oil_level_high, 100). % Maksymalny poziom oleju
threshold(battery_voltage_low, 11.5). % Minimalne napięcie akumulatora (V)
threshold(battery_voltage_high, 14.5). % Maksymalne napięcie akumulatora (V)
threshold(fuel_consumption_high, 15). % Maksymalne zużycie paliwa (L/100km)


% === Reguły diagnozy ===
% Problem z układem paliwowym lub turbosprężarką
diagnosis('Problem z układem paliwowym lub turbosprężarką.<br>Zalecane działania:<br><ul><li>Sprawdź turbosprężarkę pod kątem uszkodzeń lub zużycia.</li><li>Wymień filtr powietrza, jeśli jest zabrudzony.</li><li>Skorzystaj z diagnostyki komputerowej, aby zidentyfikować dokładny kod błędu (np. OBD2).</li></ul><br>Warto sprawdzić:<br><a href="https://autocentrumgroup.pl/jak-rozpoznac-problemy-z-ukladem-paliwowym/#:~:text=Je%C5%9Bli%20zauwa%C5%BCysz%20nieprawid%C5%82owe%20odpalanie%2C%20np,o%20problemach%20z%20uk%C5%82adem%20paliwowym.">https://autocentrumgroup.pl/jak-rozpoznac-problemy-z-ukladem-paliwowym</a><br><br>Jeżeli nie rozwiązało to problemu, skontaktuj się z mechanikiem.<br>') :-
    (fact(engine_check_light_on, yes); fact(strange_noise, yes)),
    fact(smoke_color, black),
    fact(fuel_efficiency, poor),
    fact(fuel_consumption, Consumption),
    threshold(fuel_consumption_high, Limit),
    Consumption > Limit.

% Możliwe uszkodzenie uszczelki pod głowicą
diagnosis('Możliwe uszkodzenie uszczelki pod głowicą.<br>Zalecane działania:<br><ul><li>Sprawdź poziom płynu chłodniczego i poszukaj śladów oleju w zbiorniku.</li><li>Użyj testera CO2, aby sprawdzić obecność spalin w układzie chłodzenia.</li><li>Skonsultuj się z mechanikiem w celu wymiany uszczelki pod głowicą, jeśli testy wykażą jej uszkodzenie.</li></ul><br>Warto sprawdzić:<br><a href="https://www.intermotors.pl/czytaj/porady-dla-motocyklistow/uszkodzona-uszczelka-pod-glowicajakie-sa-objawy-jak-ja-zdiagnozowac-jak-wymienic#:~:text=Objawami%20uszkodzonej%20uszczelki%20pod%20g%C5%82owic%C4%85,to%20trudny%20i%20z%C5%82o%C5%BCony%20proces.">https://www.intermotors.pl/czytaj/porady-dla-motocyklistow/uszkodzona-uszczelka-pod-glowicajakie-sa-objawy-jak-ja-zdiagnozowac-jak-wymienic</a><br>') :-
    fact(engine_check_light_on, yes),
    (fact(smoke_color, white); fact(overheating, yes)),
    fact(leaking_fluid, yes).

% Sprawdź układ wydechowy lub zawieszenie
diagnosis('Sprawdź układ wydechowy lub zawieszenie.<br>Zalecane działania:<br><ul><li>Skontroluj układ wydechowy pod kątem pęknięć, dziur lub poluzowanych mocowań.</li><li>Sprawdź stan zawieszenia, szczególnie tuleje i amortyzatory.</li><li>Ustaw prawidłowe ciśnienie w oponach.</li></ul><br>Warto sprawdzić:<br><a href="https://www.ucando.pl/blog/najczestsze-usterki-ukladu-wydechowego-w-samochodzie-co-sie-psuje-dlaczego-sie-psuje-oraz-jakie-sa-typowe-objawy-awarii/">https://www.ucando.pl/blog/najczestsze-usterki-ukladu-wydechowego-w-samochodzie-co-sie-psuje-dlaczego-sie-psuje-oraz-jakie-sa-typowe-objawy-awarii/</a><br>') :-
    (fact(strange_noise, yes);fact(brake_issue, yes)).

% Wycieki oleju mogą powodować przegrzewanie się silnika
diagnosis('Wycieki oleju i niskie ciśnienie oleju mogą powodować przegrzewanie.<br>Zalecane działania:<br><ul><li>Skontroluj silnik pod kątem wycieków oleju w okolicach uszczelki głowicy i miski olejowej.</li><li>Uzupełnij poziom oleju zgodnie z zaleceniami producenta.</li><li>Wymień uszkodzone uszczelki i sprawdź stan pompy oleju.</li></ul><br>Warto sprawdzić:<br><a href="https://autoskup.biz/blog/wyciek-oleju-przyczyny-objawy-i-jak-naprawic">https://autoskup.biz/blog/wyciek-oleju-przyczyny-objawy-i-jak-naprawic</a><br>') :-
    fact(overheating, yes),
    fact(oil_leak, yes),
    fact(oil_level, Level),
    threshold(oil_level_low, Min),
    Level < Min.

% Problem z ciśnieniem w oponach
diagnosis('Problem z ciśnieniem w oponach.<br>Zalecane działania:<br><ul><li>Sprawdź ciśnienie w oponach i dostosuj je do zaleceń producenta.</li><li>Poszukaj nieszczelności w oponach, takich jak dziury lub pęknięcia.</li><li>Jeśli opona jest poważnie uszkodzona, wymień ją na nową.</li></ul><br>Warto sprawdzić:<br><a href="https://www.serwisogumieniaprudnik.pl/blog/po-czym-poznac-ze-cisnienie-w-oponie-jest-za-niskie">https://www.serwisogumieniaprudnik.pl/blog/po-czym-poznac-ze-cisnienie-w-oponie-jest-za-niskie</a><br>') :-
    fact(tire_pressure, Pressure),
    threshold(tire_pressure_low, Min),
    threshold(tire_pressure_high, Max),
    (Pressure < Min ; Pressure > Max),
    (fact(brake_issue, yes);fact(strange_noise, yes)).

% Niski poziom oleju
diagnosis('Niski poziom oleju.<br>Zalecane działania:<br><ul><li>Uzupełnij olej i sprawdź, czy poziom się utrzymuje.</li><li>Poszukaj wycieków w silniku lub sprawdź stan pierścieni tłokowych.</li><li>W przypadku czarnego dymu, skonsultuj się z mechanikiem, ponieważ spalanie oleju może wskazywać na poważne problemy z silnikiem.</li></ul><br>Warto sprawdzić:<br><a href="https://www.mihel.pl/objawy-braku-oleju-w-silniku-co-sygnalizuje-pustki-w-misce-olejowej/">https://www.mihel.pl/objawy-braku-oleju-w-silniku-co-sygnalizuje-pustki-w-misce-olejowej/</a><br>') :-
    fact(oil_level, Level),
    threshold(oil_level_low, Min),
    Level < Min,
    (fact(engine_check_light_on, yes);fact(strange_noise, yes)).

% Problem z akumulatorem
diagnosis('Problem z akumulatorem.<br>Zalecane działania:<br><ul><li>Sprawdź napięcie akumulatora za pomocą multimetru.</li><li>Jeśli napięcie jest poniżej zalecanego poziomu (zwykle 12,4 V dla w pełni naładowanego akumulatora), naładuj akumulator lub wymień go na nowy.</li><li>Skontroluj alternator i jego wydajność ładowania. Napięcie podczas pracy silnika powinno wynosić 13,8–14,4 V.</li><li>Sprawdź stan klem akumulatora i połączeń – mogą być skorodowane.</li></ul><br>Warto sprawdzić:<br><a href="https://www.euromaster.pl/porady/co-zle-wplywa-na-akumulator">https://www.euromaster.pl/porady/co-zle-wplywa-na-akumulator</a><br>') :-
    fact(battery_voltage, Voltage),
    threshold(battery_voltage_low, Min),
    Voltage < Min.
    fact(engine_check_light_on, yes).

% Zbyt wysokie zużycie paliwa
diagnosis('Zbyt wysokie zużycie paliwa.<br>Zalecane działania:<br><ul><li>Sprawdź stan wtryskiwaczy paliwa – mogą być zabrudzone lub uszkodzone.</li><li>Skontroluj sondę lambda, która odpowiada za mieszankę paliwowo-powietrzną.</li><li>Wykonaj diagnostykę komputerową, aby sprawdzić parametry pracy silnika.</li><li>Regularnie wymieniaj filtr powietrza – zabrudzony filtr może zwiększać zużycie paliwa.</li><li>Upewnij się, że opony mają prawidłowe ciśnienie – nieodpowiednie ciśnienie wpływa na opór toczenia i zużycie paliwa.</li></ul><br>Warto sprawdzić:<br><a href="https://www.flotex.pl/zwiekszone-zuzycie-paliwa-sprawdz-co-moze-byc-przyczyna/">https://www.flotex.pl/zwiekszone-zuzycie-paliwa-sprawdz-co-moze-byc-przyczyna/</a><br>') :-
    fact(fuel_consumption, Consumption),
    threshold(fuel_consumption_high, Limit),
    Consumption > Limit.

% Przegrzewanie silnika
diagnosis('Przegrzewanie silnika.<br>Zalecane działania:<br><ul><li>Sprawdź termostat – może być zablokowany w pozycji zamkniętej, co uniemożliwia cyrkulację płynu chłodniczego.</li><li>Skontroluj poziom płynu chłodniczego – niski poziom może prowadzić do przegrzewania. Warto też sprawdzić poziom oleju. </li><li>Sprawdź działanie wentylatora chłodnicy – upewnij się, że włącza się podczas wzrostu temperatury.</li><li>Skontroluj chłodnicę pod kątem zabrudzeń lub zablokowanych kanałów przepływu.</li><li>Wykonaj test ciśnienia w układzie chłodzenia, aby wykluczyć nieszczelności.</li></ul><br>Warto sprawdzić:<br><a href="https://k2.com.pl/blog/przegrzanie-silnika-objawy-przyczyny-i-skutki/">https://k2.com.pl/blog/przegrzanie-silnika-objawy-przyczyny-i-skutki/</a><br>') :-
    fact(overheating, yes),
    (fact(strange_noise,yes);fact(fuel_efficiency, poor);(fact(oil_level, Level),threshold(oil_level_low, Min),Level < Min)).

% Jeśli żadna z reguł nie pasuje
diagnosis('Brak jednoznacznej diagnozy. Skontaktuj się z mechanikiem.<br>') :-
    \+ diagnosis(_).
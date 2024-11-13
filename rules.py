def apply_rules(data):
    # Baza wiedzy (fakty)
    facts = {
        'engine_check_light_on': data['engine_check_light'] == 'yes',
        'strange_noise': data['strange_noise'] == 'yes',
        'black_smoke': data['smoke_color'] == 'black',
        'white_smoke': data['smoke_color'] == 'white',
        'poor_fuel_efficiency': data['fuel_efficiency'] == 'poor',
        'overheating': data['overheating'] == 'yes',
        'oil_leak': data['oil_leak'] == 'yes',
        'brake_issue': data['brake_issue'] == 'yes'
    }
    
    # Reguły wnioskowania
    if facts['engine_check_light_on'] and facts['black_smoke']:
        return "Problem z układem paliwowym lub turbosprężarką."
    
    if facts['engine_check_light_on'] and facts['white_smoke']:
        return "Możliwe uszkodzenie uszczelki pod głowicą."
    
    if facts['strange_noise']:
        return "Sprawdź układ wydechowy lub zawieszenie."
    
    if facts['poor_fuel_efficiency']:
        return "Zalecana diagnostyka układu paliwowego."

    if facts['overheating']:
        if facts['oil_leak']:
            return "Wycieki oleju mogą powodować przegrzewanie się silnika. Sprawdź uszczelki."
        else:
            return "Przegrzewanie silnika. Sprawdź układ chłodzenia."

    if facts['brake_issue']:
        return "Problem z układem hamulcowym. Sprawdź klocki hamulcowe lub płyn hamulcowy."
    
    return "Brak jednoznacznej diagnozy. Skontaktuj się z mechanikiem."

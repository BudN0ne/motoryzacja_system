# -*- coding: utf-8 -*-
from flask import Flask, render_template, request
from swiplserver import PrologMQI

app = Flask(__name__)
app.config['JSON_AS_ASCII'] = False

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/diagnose', methods=['POST'])
def diagnose():
    # Pobieranie danych z formularza
    data = {
        'engine_check_light_on': request.form.get('engine_check_light'),
        'strange_noise': request.form.get('strange_noise'),
        'smoke_color': request.form.get('smoke_color'),
        'fuel_efficiency': request.form.get('fuel_efficiency'),
        'overheating': request.form.get('overheating'),
        'oil_leak': request.form.get('oil_leak'),
        'brake_issue': request.form.get('brake_issue'),
        'tire_pressure': request.form.get('tire_pressure'),
        'oil_level': request.form.get('oil_level'),
        'battery_voltage': request.form.get('battery_voltage'),
        'fuel_consumption': request.form.get('fuel_consumption')
    }

    # Połączenie z Prologiem i wczytanie bazy wiedzy
    with PrologMQI() as mqi:
        with mqi.create_thread() as prolog_thread:
            prolog_thread.query("set_prolog_flag(encoding, utf8)")
            prolog_thread.query("consult('knowledge_base.pl')")

            # Wstawianie faktów na podstawie danych z formularza
            for fact, value in data.items():
                if value and (value == 'yes' or value.isdigit() or value in ['black', 'white', 'poor', 'good']):
                    prolog_thread.query(f"assertz(fact({fact}, {value}))")

            # Zapytanie o diagnozę
            result = prolog_thread.query("diagnosis(Diagnosis)")

            # Czyszczenie faktów po diagnozie
            for fact in data.keys():
                prolog_thread.query(f"retractall(fact({fact}, _))")

            # Przetwarzanie wyniku diagnozy
            if result:
                diagnosis = [res['Diagnosis'] for res in result]
            else:
                diagnosis = ["Brak jednoznacznej diagnozy. Skontaktuj się z mechanikiem."]

    return render_template('result.html', diagnosis=diagnosis)

if __name__ == '__main__':
    app.run(debug=True)
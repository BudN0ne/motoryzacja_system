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
    data = {
        'engine_check_light': request.form.get('engine_check_light'),
        'strange_noise': request.form.get('strange_noise'),
        'smoke_color': request.form.get('smoke_color'),
        'fuel_efficiency': request.form.get('fuel_efficiency'),
        'overheating': request.form.get('overheating'),
        'oil_leak': request.form.get('oil_leak'),
        'brake_issue': request.form.get('brake_issue')
    }

    with PrologMQI() as mqi:
        with mqi.create_thread() as prolog_thread:
            prolog_thread.query("set_prolog_flag(encoding, utf8)")
            prolog_thread.query("consult('knowledge_base.pl')")
            for fact, value in data.items():
                if value == 'yes' or value in ['black', 'white', 'poor']:
                    prolog_thread.query(f"assertz(fact({fact}, {value}))")
            result = prolog_thread.query("diagnosis(Diagnosis)")
            for fact in data.keys():
                prolog_thread.query(f"retractall(fact({fact}, _))")
    
    # Dekodowanie wyniku jako UTF-8
    diagnosis = result[0]['Diagnosis'] if result else "Brak jednoznacznej diagnozy. Skontaktuj się z mechanikiem."
    
    return render_template('result.html', diagnosis=diagnosis)

if __name__ == '__main__':
    app.run(debug=True)
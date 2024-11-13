from flask import Flask, render_template, request
from rules import apply_rules

app = Flask(__name__)

# Strona główna
@app.route('/')
def index():
    return render_template('index.html')

# Obsługa formularza i wyświetlenie wyników
@app.route('/diagnose', methods=['POST'])
def diagnose():
    # Pobranie danych od użytkownika
    data = {
        'engine_check_light': request.form.get('engine_check_light'),
        'strange_noise': request.form.get('strange_noise'),
        'smoke_color': request.form.get('smoke_color'),
        'fuel_efficiency': request.form.get('fuel_efficiency'),
        'overheating': request.form.get('overheating'),
        'oil_leak': request.form.get('oil_leak'),
        'brake_issue': request.form.get('brake_issue')
    }
    
    # Zastosowanie reguł wnioskowania
    diagnosis = apply_rules(data)
    
    return render_template('result.html', diagnosis=diagnosis)

if __name__ == '__main__':
    app.run(debug=True)
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(  

      home: Scaffold(
        appBar: AppBar(  

          title: Text('Formulario de IUJO'),
        ),
        body: MyForm(),
      ),
    );
  }
}

class MyForm extends StatefulWidget {
  @override
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  final _formKey = GlobalKey<FormState>(); 

  String _nombre = ''; // Initialize string variables
  bool _trabaja = false;
  bool _estudia = false;
  String _genero = '';  // Initialize string variables
  bool _notificaciones = false;
  double _precio = 0.0;
  DateTime _fecha =DateTime.now();
  TimeOfDay _hora =TimeOfDay.now() ;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        padding: EdgeInsets.all(16.0),
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(labelText: 
 'Nombre'),
            validator: (value) { // Add validation for empty name
              if (value!.isEmpty) {
                return 'Por favor, ingresa tu nombre';
              }
              return null;
            },
            onSaved: (value) => _nombre = value!,
          ),
          SwitchListTile(
            title: Text('Trabaja'),
            value: _trabaja,
            onChanged: (value) => setState(() => _trabaja = value),
          ),
          SwitchListTile(
            title: Text('Estudia'),
            value: _estudia,
            onChanged: (value) => setState(() => _estudia = value),
          ),
          DropdownButtonFormField<String>(
            decoration: InputDecoration(labelText: 'Género'),
            items: ['Masculino', 'Femenino'].map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (newValue) => setState(() => _genero = newValue!),
          ),
          SwitchListTile(
            title: Text('Notificaciones'),
            value: _notificaciones,
            onChanged: (value) => setState(() => _notificaciones = value),
          ),
          Slider(
            value: _precio,
            min: 0,
            max: 100,
            divisions: 10,
            label: _precio.round().toString(),
            onChanged: (value) => setState(() => _precio = value),
          ),
          ElevatedButton(
            onPressed: () async {
              final DateTime? picked = await showDatePicker(
                context: context,
                initialDate: DateTime.now(), 

                firstDate: DateTime(2000),
                lastDate: DateTime(2101),
              );
              if (picked != null)  
 setState(() => _fecha = picked);
            },
            child: Text('Seleccionar Fecha'),
          ),
          ElevatedButton(
            onPressed: () async {
              final TimeOfDay? picked = await showTimePicker(
                context: context,
                initialTime: TimeOfDay.now(),
              );
              if (picked != null) setState(()  
 => _hora = picked);
            },
            child: Text('Seleccionar Hora'),
          ),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) { // Validate form
                _formKey.currentState!.save(); // Save form data
                // Process form data (e.g., print, send to server)
                print('Nombre: $_nombre');
                // ... print other data
              }
            },
            child: Text('Enviar'),
          ),
        ],
      ),
    );
  }
}

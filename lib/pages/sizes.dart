// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'package:flutter/material.dart';

class SizesPage extends StatelessWidget {
  const SizesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BodyMeasurementForm(),
    );
  }
}

class BodyMeasurementForm extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _BodyMeasurementFormState createState() => _BodyMeasurementFormState();
}

class _BodyMeasurementFormState extends State<BodyMeasurementForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late BodyMeasurement _bodyMeasurement;
  final List<BodyMeasurement> _measurements = [];

  @override
  void initState() {
    super.initState();
    _bodyMeasurement = BodyMeasurement(
      weight: 0.0,
      armSize: 0.0,
      thighSize: 0.0,
      waistSize: 0.0,
      chestSize: 0.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Body Measurements'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Weight (kg)'),
                    keyboardType: TextInputType.number,
                    onSaved: (value) {
                      _bodyMeasurement.weight = double.tryParse(value!) ?? 0.0;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Arm Size (cm)'),
                    keyboardType: TextInputType.number,
                    onSaved: (value) {
                      _bodyMeasurement.armSize = double.tryParse(value!) ?? 0.0;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Thigh Size (cm)'),
                    keyboardType: TextInputType.number,
                    onSaved: (value) {
                      _bodyMeasurement.thighSize =
                          double.tryParse(value!) ?? 0.0;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Waist Size (cm)'),
                    keyboardType: TextInputType.number,
                    onSaved: (value) {
                      _bodyMeasurement.waistSize =
                          double.tryParse(value!) ?? 0.0;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Chest Size (cm)'),
                    keyboardType: TextInputType.number,
                    onSaved: (value) {
                      _bodyMeasurement.chestSize =
                          double.tryParse(value!) ?? 0.0;
                    },
                  ),
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () {
                      _submitForm();
                    },
                    child: Text('Add Measurement'),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Body Measurements List:',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.separated(
                itemCount: _measurements.length,
                separatorBuilder: (context, index) => Divider(),
                itemBuilder: (context, index) {
                  final measurement = _measurements[index];
                  return SingleChildScrollView(
                    child: ListTile(
                      title: Text(
                        'Weight: ${measurement.weight} kg, Arm Size: ${measurement.armSize} cm',
                      ),
                      subtitle: Text(
                        'Thigh: ${measurement.thighSize} cm, Chest: ${measurement.chestSize} cm',
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // Save the body measurement data to your storage or database
      // You can use _bodyMeasurement to access the entered values.

      print('Adding measurement: $_bodyMeasurement');

      setState(() {
        _measurements.add(_bodyMeasurement);
      });

      print('Measurements after adding: $_measurements');

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Body measurement added successfully!'),
        ),
      );
    }
  }
}

class BodyMeasurement {
  double weight;
  double armSize;
  double thighSize;
  double waistSize;
  double chestSize;

  BodyMeasurement({
    required this.weight,
    required this.armSize,
    required this.thighSize,
    required this.waistSize,
    required this.chestSize,
  });
}

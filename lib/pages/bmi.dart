// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class BMIPage extends StatelessWidget {
  const BMIPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: MyBMIForm(),
    );
  }
}

class MyBMIForm extends StatefulWidget {
  const MyBMIForm({super.key});

  @override
  _MyBMIFormState createState() => _MyBMIFormState();
}

class _MyBMIFormState extends State<MyBMIForm> {
  final _formKey = GlobalKey<FormState>();
  String gender = 'Male';
  double height = 170.0;
  double weight = 70.0;
  int age = 25;
  String result = '';
  Color resultColor = Colors.black;

  void _calculateBMI() {
    // BMI formula: weight (kg) / (height (m) * height (m))
    double heightInMeters = height / 100;
    double bmi = weight / (heightInMeters * heightInMeters);

    // Classify BMI
    String classification = '';
    if (bmi < 18.5) {
      classification = 'Underweight';
      resultColor = Colors.red;
    } else if (bmi >= 18.5 && bmi < 25) {
      classification = 'Normal weight';
      resultColor = Colors.green;
    } else if (bmi >= 25 && bmi < 30) {
      classification = 'Overweight';
      resultColor = Colors.red;
    } else {
      classification = 'Obese';
      resultColor = Colors.red;
    }

    // Show BMI in a popup
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('BMI Result'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Your BMI: ${bmi.toStringAsFixed(2)}', style: TextStyle(color: resultColor)),
              SizedBox(height: 8),
              Text('Classification: $classification', style: TextStyle(color: resultColor)),
            ],
          ),
          actions: <Widget>[
            ElevatedButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BMI Calculator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              DropdownButtonFormField(
                value: gender,
                items: ['Male', 'Female'].map((String value) {
                  return DropdownMenuItem(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? value) {
                  setState(() {
                    gender = value!;
                  });
                },
                decoration: InputDecoration(labelText: 'Gender'),
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Height (cm)'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your height';
                  }
                  return null;
                },
                onSaved: (value) {
                  height = double.parse(value!);
                },
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Weight (kg)'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your weight';
                  }
                  return null;
                },
                onSaved: (value) {
                  weight = double.parse(value!);
                },
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Age'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your age';
                  }
                  return null;
                },
                onSaved: (value) {
                  age = int.parse(value!);
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    _calculateBMI();
                  }
                },
                child: Text('Calculate BMI'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
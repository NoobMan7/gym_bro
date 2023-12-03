// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        title: Text('Gym Bro'),
      ),
      body: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Exercise> exercises = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: () {
                _showAddExerciseDialog(context);
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children:const [
                    Icon(Icons.add),
                    SizedBox(width: 8.0),
                    Text('Add Exercise'),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Expanded(
              child: ListView.builder(
                itemCount: exercises.length,
                itemBuilder: (context, index) {
                  return ExerciseCard(exercise: exercises[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showAddExerciseDialog(BuildContext context) {
  String exerciseName = '';
  int sets = 3; // Always 3 sets
  List<int> repsList = [0, 0, 0];
  List<double> weightsList = [0.0, 0.0, 0.0];

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('Add Exercise'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Exercise Name'),
                onChanged: (value) {
                  exerciseName = value;
                },
              ),
              for (var i = 0; i < sets; i++)
                Column(
                  children: [
                    Text('Set ${i + 1}'),
                    TextField(
                      decoration: InputDecoration(labelText: 'Reps ${i + 1}'),
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        repsList[i] = int.tryParse(value) ?? 0;
                      },
                    ),
                    TextField(
                      decoration: InputDecoration(labelText: 'Weight ${i + 1}'),
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        weightsList[i] = double.tryParse(value) ?? 0.0;
                      },
                    ),
                  ],
                ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (exerciseName.isNotEmpty) {
                Exercise newExercise = Exercise(
                  name: exerciseName,
                  sets: sets,
                  setInfoList: [
                    SetInfo(reps: repsList[0], weight: weightsList[0]),
                    SetInfo(reps: repsList[1], weight: weightsList[1]),
                    SetInfo(reps: repsList[2], weight: weightsList[2]),
                  ],
                );
                setState(() {
                  exercises.add(newExercise);
                });
                Navigator.pop(context);
              }
            },
            child: Text('Save'),
          ),
        ],
      );
    },
  );
}

}
class ExerciseCard extends StatelessWidget {
  final Exercise exercise;

  ExerciseCard({required this.exercise});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Exercise: ${exercise.name}',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Sets: ${exercise.sets}',
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 8.0),
            for (var i = 0; i < exercise.sets; i++)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Set ${i + 1}:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    'Reps: ${exercise.setInfoList[i].reps}, Weight: ${exercise.setInfoList[i].weight}',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 8.0),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

class Exercise {
  final String name;
  final int sets;
  final List<SetInfo> setInfoList;

  Exercise({required this.name, required this.sets, required this.setInfoList});
}

class SetInfo {
  final int reps;
  final double weight;

  SetInfo({required this.reps, required this.weight});
}

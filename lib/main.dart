import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final distanceController = TextEditingController();

  final speedController = TextEditingController();

  final restBreaksController = TextEditingController();

  final restDurationController = TextEditingController();

  String arrivalTime = '';

  void calculateTravelTime() {
    double? distance = double.tryParse(distanceController.text);
    double? speed = double.tryParse(speedController.text);
    int? restBreaks = int.tryParse(restBreaksController.text);
    int? restDuration = int.tryParse(restDurationController.text);

    if (distance != null &&
        speed != null &&
        restBreaks != null &&
        restDuration != null &&
        speed > 0) {
      double travelHours = distance / speed;
      double totalHours = travelHours + (restBreaks * restDuration);


      setState(() {
        arrivalTime = totalHours.toString(
      });
    } else {
      setState(() {
        arrivalTime = '';
      });
    }
    dispose() {
      distanceController.dispose();
      speedController.dispose();
      restBreaksController.dispose();
      restDurationController.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Travel Time Calculator')),
        body: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextFeild('Distance (km)', distanceController),
              CustomTextFeild('Speed (km/h)', speedController),
              CustomTextFeild('Number of Rest Breaks', restBreaksController),
              CustomTextFeild('Rest Duration (0.5 hr)', restDurationController),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: calculateTravelTime,
                child: Text('Calculate Travel Time'),
              ),
              SizedBox(height: 16),

              if (arrivalTime.isNotEmpty)
                Text(' Time Needed: $arrivalTime hrs',
                    style: TextStyle(fontSize: 18)),
            ],
          ),
        ),
      ),
    );
  }
}

Widget CustomTextFeild(String label, TextEditingController controller) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8.0),
    child: TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
    ),
  );
}

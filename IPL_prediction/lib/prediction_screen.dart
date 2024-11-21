import 'package:flutter/material.dart';
import 'dart:convert'; 
import 'package:http/http.dart' as http; 
class PredictionScreen extends StatefulWidget {
  const PredictionScreen({super.key});

  @override
  _PredictionScreenState createState() => _PredictionScreenState();
}

class _PredictionScreenState extends State<PredictionScreen> {
  // Define the select options
  List<String> teams = [
    'Royal Challengers Bangalore',
    'Rising Pune Supergiant',
    'Kings XI Punjab',
    'Delhi Daredevils',
    'Mumbai Indians',
    'Kolkata Knight Riders',
    'Sunrisers Hyderabad',
    'Rajasthan Royals',
    'Chennai Super Kings',
    'Deccan Chargers',
    'Rising Pune Supergiants',
    'Delhi Capitals'
  ];

  List<String> cities = [
    'Hyderabad',
    'Pune',
    'Indore',
    'Bangalore',
    'Mumbai',
    'Kolkata',
    'Delhi',
    'Chandigarh',
    'Jaipur',
    'Chennai',
    'Cape Town',
    'Port Elizabeth',
    'Durban',
    'Centurion',
    'East London',
    'Johannesburg',
    'Kimberley',
    'Bloemfontein',
    'Ahmedabad',
    'Cuttack',
    'Nagpur',
    'Dharamsala',
    'Visakhapatnam',
    'Raipur',
    'Ranchi',
    'Abu Dhabi',
    'Sharjah',
    'Mohali',
    'Bengaluru'
  ];

  String? selectedBattingTeam;
  String? selectedBowlingTeam;
  String? selectedCity;
  int totalRuns = 0;
  int runsLeft = 0;
  int ballsLeft = 0;
  double crr = 0.0;
  double rrr = 0.0;
  int wickets = 0;

  String predictionResult = "";

  // Helper function to safely parse a double value from input
  double parseDouble(String value) {
    try {
      return value.isNotEmpty ? double.parse(value) : 0.0;
    } catch (e) {
      return 0.0; // Return a default value if parsing fails
    }
  }

  // This is where you make the POST request to the FastAPI backend
  Future<void> getPrediction() async {
    // Prepare the input data
    final Map<String, dynamic> inputData = {
      'batting_team': selectedBattingTeam,
      'bowling_team': selectedBowlingTeam,
      'city': selectedCity,
      'total_runs_x': totalRuns,
      'runs_left': runsLeft,
      'balls_left': ballsLeft,
      'crr': crr,
      'rrr': rrr,
      'wickets': wickets
    };

    try {
      // Call the FastAPI backend via POST request
      final response = await http.post(
        Uri.parse(
            'http://192.168.177.189:8000/getProbs'), // Use your machine's IP here
        headers: {'Content-Type': 'application/json'},
        body: json.encode(inputData),
      );
      print('Response Body: ${response.body}');

      // Check the status code for success (200 OK)
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        setState(() {
          predictionResult =
              "$selectedBattingTeam: ${data['team1'].toStringAsFixed(2)}\n$selectedBowlingTeam: ${data['team2'].toStringAsFixed(2)}";
        });
      } else {
        setState(() {
          predictionResult = "Error: Unable to fetch prediction";
        });
      }
    } catch (e) {
      setState(() {
        predictionResult = "Error: $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Prediction Screen"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/login');
            },
            icon: const Icon(Icons.logout),
            tooltip: 'Log Out',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Batting Team Dropdown
              DropdownButtonFormField<String>(
                value: selectedBattingTeam,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedBattingTeam = newValue!;
                  });
                },
                items: teams.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                decoration:
                    const InputDecoration(labelText: "Select Batting Team"),
              ),
              const SizedBox(height: 16),
              // Bowling Team Dropdown
              DropdownButtonFormField<String>(
                value: selectedBowlingTeam,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedBowlingTeam = newValue!;
                  });
                },
                items: teams.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                decoration:
                    const InputDecoration(labelText: "Select Bowling Team"),
              ),
              const SizedBox(height: 16),
              // City Dropdown
              DropdownButtonFormField<String>(
                value: selectedCity,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedCity = newValue!;
                  });
                },
                items: cities.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                decoration: const InputDecoration(labelText: "Select City"),
              ),
              const SizedBox(height: 16),
              // Total Runs
              // Add text fields or sliders for other inputs here as needed

              const SizedBox(height: 32),
              // Submit Button
              ElevatedButton(
                onPressed: getPrediction,
                child: const Text("Get Prediction"),
              ),
              const SizedBox(height: 16),
              // Display Prediction Result
              Text(predictionResult),
            ],
          ),
        ),
      ),
    );
  }
}

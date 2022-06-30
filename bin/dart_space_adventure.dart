/*
  Student: Stephen Chow
  Email: chowst@oregonstate.edu
  Course: CS492 - Mobile Software Development
  Last Updated: 6/29/22
*/

import 'dart:convert';
import "dart:io";
import "dart:math";

import 'package:dart_space_adventure/dart_space_adventure.dart'
    as dart_space_adventure;
import 'package:test/expect.dart';

var filePath = "";

// Classes
class Planet {
  final String name;
  final String description;

  // Constructor
  Planet(this.name, this.description);
}

// JSON DATA
var jsonData = {};

List<Planet> planets = [];

/*
  - getInput from user
  - Use a loop to repeatedly ask user until they say Y or N
*/
bool getInput() {
  print("Shall I randomly choose a planet for you to visit? (Y or N)");
  // Read user input from stdin
  String userResponse = stdin.readLineSync() ?? '';
  // Convert user input to lowercase
  userResponse = userResponse.toLowerCase();

  // Loop to keep prompting user for Y/Yes or N/No
  while (userResponse != 'y' ||
      userResponse != 'n' ||
      userResponse != "no" ||
      userResponse != "yes") {
    if (userResponse == 'y' || userResponse == 'yes') {
      return true;
    } else if (userResponse == 'n' || userResponse == 'no') {
      print("Name the planet you would like to visit.");
      return false;
    }
    // User didn't enter Y or N - Keep prompting user for response
    else {
      print(
        "Sorry, I didn't get that\n"
        "Shall I randomly choose a planet for you to visit? (Y or N)",
      );

      // Read user input from stdin
      userResponse = stdin.readLineSync() ?? '';
      // Convert user input to lowercase
      userResponse = userResponse.toLowerCase();
    }
  }
  return false;
}

/*
  - Read JSON for Planetary System
  - Currently synchronous since I don't want it to be asynchronous
  - Non-blocking was messing me up
*/
void readJson() {
  var config = File(filePath);
  var stringContents = config.readAsStringSync(); // String
  // Convert String to JSON
  jsonData = jsonDecode(stringContents); // JSON

  jsonData["planets"].forEach((e) {
    planets.add(Planet(e['name'], e['description']));
  });
}

/*
  - Print planet user is traveling to
*/
void travel(chosenPlanet) => print(
      "Traveling to ${chosenPlanet.name}...\n"
      "Arrived at ${chosenPlanet.name}. ${chosenPlanet.description}",
    );

/*
  
*/
Planet randomize() {
  // Random idx in planets list
  var randIdx = Random().nextInt(planets.length);
  // Random planet from planets List
  return planets[randIdx];
}

/*
  - main fxn
*/
void main(List<String> args) {
  // Tell user how to use program
  if (args.length != 1) {
    print(
      "USAGE: \$main.dart path_to_json\n"
      "Ex: \$bin/dart_space_adventure.dart assets/planetarySystem.json\n",
    );
  }

  // Set filePath to path user specified
  filePath = args[0];

  // Load planet data from planetarySystem.json
  readJson();

  // Greet user. Get user's name
  print(
    "Welcome to the Solar System!\n"
    "There are 9 planets to explore\n"
    "What is your name?",
  );

  // Read user's name from stdin
  String name = stdin.readLineSync() ?? '';

  print(
    "Nice to meet you $name. My name is Stephen, I'm an old friend of Alexa\n"
    "Let's go on an adventure!",
  );

  // Get input from user
  // true = randomPlanet
  // false = Not a randomPlanet
  bool randomPlanetChosen = getInput();
  // User chose a RANDOM planet
  if (randomPlanetChosen) {
    print("Selecting a random planet");
    // Select random planet
    Planet randomPlanet = randomize();
    travel(randomPlanet);
  }
  // User chose a SPECIFIC planet
  else {
    print("What planet did you want to select?");
    String usersPlanet = stdin.readLineSync() ?? '';

    Planet destination = Planet('Null', 'Null');

    // Loop through planets list
    for (Planet p in planets) {
      // Check if planet in planets List
      if (p.name == usersPlanet) {
        destination = p;
      }
    }

    // Fly to planet user chose
    travel(destination);
  }
}


/*
------------------------------- NOTES -------------------------------
Create dart project:
  $dart create dart_space_adventure
  
Run a dart project (from root of project directory):
    $dart bin/dart_space_adventure.dart assets/planetarySystem.json

  
*/
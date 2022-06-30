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
  - Get randome idx for planets List
  - Use random idx to get random planet in planets List
*/
Planet randomize() {
  // Random idx in planets list
  var randIdx = Random().nextInt(planets.length);
  // Random planet from planets List
  return planets[randIdx];
}

/*
  - Greet & welcome user
*/
void greetUser() => print(
      "Welcome to the Solar System!\n"
      "There are ${planets.length} planets to explore\n"
      "What is your name?",
    );

/*
  - Get user's name from stdin
  - Introduce self to user
*/
void introduceSelf() {
  // Read user's name from stdin
  String name = stdin.readLineSync() ?? '';
  print(
    "Nice to meet you $name. My name is GOD, I'm an old friend of Alexa\n"
    "Let's go on an adventure!",
  );
}

/*
  - Choose planet (random or specific)
*/
Planet choosePlanet() {
  // Get input from user (true = randomPlanet, false = Not a randomPlanet)
  bool randomPlanetChosen = getInput();

  // Initialize destation to be Null
  Planet destination = Planet('Null', 'Null');

  // User chose a RANDOM planet
  if (randomPlanetChosen) {
    // Select random planet
    destination = randomize();
  }
  // User chose a SPECIFIC planet
  else {
    // Prompt user for what planet they'd like to visit
    String usersPlanet = stdin.readLineSync() ?? '';

    // Loop through planets list
    for (Planet p in planets) {
      // Check if planet in planets List
      if (p.name == usersPlanet) {
        destination = p;
      }
    }
  }

  return destination;
}

/*
  - Read CL args
*/
void checkArgs(args) {
  // Tell user how to use program
  if (args.length != 1) {
    print("USAGE: \$main.dart path_to_json\n");
    // Terminate & exit program
    exit(0);
  }

  // Set filePath to path user specified
  filePath = args[0];
}

/*
  - main fxn
*/
void main(List<String> args) {
  checkArgs(args);

  // Load planet data from planetarySystem.json
  readJson();

  // Greet user. Get user's name
  greetUser();

  // Introduce self to user
  introduceSelf();

  // Fly to planet user chose or random planet
  travel(choosePlanet());
}


/*
------------------------------- NOTES -------------------------------
Create dart project:
  $dart create dart_space_adventure
  
Run a dart project (from root of project directory):
    $dart bin/dart_space_adventure.dart assets/planetarySystem.json

  
*/
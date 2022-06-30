/*
  Student: Stephen Chow
  Email: chowst@oregonstate.edu
  Course: CS492 - Mobile Software Development
  Last Updated: 6/29/22
*/

import "dart:io";
import 'dart:convert';

import 'package:dart_space_adventure/dart_space_adventure.dart'
    as dart_space_adventure;
import 'package:test/expect.dart';

const filePath = "./assets/planetarySystem.json";

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
      print("Traveling to Earth....\n");
      return true;
    } else if (userResponse == 'n' || userResponse == 'no') {
      print("Name the planet you would like to visit.\n");
      return false;
    }
    // User didn't enter Y or N - Keep prompting user for response
    else {
      print("I'm sorry, I didn't get that\n");
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
*/
void readJson() async {
  var config = File(filePath);
  var stringContents = await config.readAsString(); // String
  // Convert String to JSON
  jsonData = jsonDecode(stringContents); // JSON

  jsonData["planets"].forEach((e) {
    planets.add(Planet(e['name'], e['description']));
  });

  for (Planet i in planets) {
    print(i.name);
  }

  // Don't have access to jsonData outside of this fxn
}

/*
  - main fxn
*/
void main() {
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
    "Let's go on an adventure!\n"
    "Shall I randomly choose a planet for you to visit? (Y or N)",
  );

  // Get input from user
  // true = randomPlanet
  // false = Not a randomPlanet
  bool randomPlanet = getInput();
  if (randomPlanet) {
    print("Selecting a random planet");
  } else {
    print("What planet did you want to select?");
  }

  // Read planetarySystem.json
  readJson();

  print(planets);
}


/*
------------------------------- NOTES -------------------------------
Create dart project:
  $dart create dart_space_adventure
  
Run a dart project (from root of project directory):
    $dart run

  
*/
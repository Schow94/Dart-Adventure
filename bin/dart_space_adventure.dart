/*
  Student: Stephen Chow
  Email: chowst@oregonstate.edu
  Course: CS492 - Mobile Software Development
  Last Updated: 6/30/22
*/

import 'package:dart_space_adventure/dart_space_adventure.dart';

/*
  - main fxn
*/
void main(List<String> args) {
  // Instantiate SpaceAdventure class
  SpaceAdventure journey = SpaceAdventure();
  // Start program
  journey.runProgram(args);
}


/*
------------------------------- NOTES -------------------------------
Run program:
  $dart bin/dart_space_adventure.dart assets/planetarySystem.json
*/
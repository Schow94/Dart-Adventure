import 'planet.dart';

// PLANET SYSTEM class
class PlanetSystem {
  final String name;
  final List<Planet> planets;

  // Constructor
  PlanetSystem({this.name = 'Unnamed System', this.planets = const []});

  // Returns number of planets
  int get numPlanets {
    return planets.length;
  }
}

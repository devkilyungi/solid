# Formula One Race Simulation

This Swift file demonstrates the implementation of a Formula One race simulation using the SOLID principles. It includes classes and protocols to handle various aspects of the race, such as car configurations, driver behaviors, track layouts, weather conditions, and pit stops. The simulation uses dynamic timers to make the race events more engaging and realistic.

## Key Components

### Car Class
Represents a Formula One car with properties like speed, fuel level, and tire condition. It uses protocols for aerodynamic configurations and tire choices to follow the Dependency Inversion Principle.

### Protocols
- **AerodynamicConfig**: Defines the aerodynamic setup of the car.
- **TireChoice**: Specifies the type of tires used.
- **Acceleration**, **Braking**, **Cornering**, and **Driver**: Define driving behaviors, supporting the Interface Segregation Principle.

### Driver Implementations
- **RecklessDriver**
- **ProfessionalDriver**
- **AmateurDriver**

These classes represent different driving styles and implement the driver protocols.

### Race Class
Manages the race logic, including starting the race, handling turns, performing pit stops, and adjusting for weather conditions. Uses timers to simulate dynamic race actions.

### PitStop Class
Handles the pit stop process, refueling the car and changing tires.

### Weather Class
Simulates different weather conditions and their effects on car performance.

### Track Layout Protocol and Implementations
- **OvalTrack**
- **CircuitTrack**

Define different track layouts and their effects on car performance.

### Dynamic Race Simulation
Uses `DispatchQueue` to introduce delays between race actions, making the simulation more interactive and realistic.

## SOLID Principles in the Code

### Single Responsibility Principle (SRP)
Each class has a single responsibility:
- **Car**: Manages car properties and actions.
- **PitStop**: Performs pit stops.
- **Weather**: Affects car performance.

### Open-Closed Principle (OCP)
The code is open for extension but closed for modification by using protocols like `AerodynamicConfig`, `TireChoice`, and `TrackLayout`. New configurations or layouts can be added without changing existing code.

### Liskov Substitution Principle (LSP)
Subtypes like `ProfessionalDriver`, `AmateurDriver`, and `RecklessDriver` can replace the `Driver` type without affecting the correctness of the program.

### Interface Segregation Principle (ISP)
The `Driver` protocol is divided into smaller, specific protocols (`Acceleration`, `Braking`, `Cornering`), ensuring that classes only implement the methods they need.

### Dependency Inversion Principle (DIP)
High-level modules (`Race`) depend on abstractions (`Driver` protocol) rather than concrete classes, allowing for flexible and interchangeable components.

## Usage Example
```swift
// Example usage demonstrating a complete race scenario.
let professionalDriver = ProfessionalDriver()
let amateurDriver = AmateurDriver()

let raceCar = Car()
raceCar.aerodynamicConfig = LowDragConfig()
raceCar.tireChoice = MediumTires()

let pitStop = PitStop()
let sunnyWeather = Weather()
sunnyWeather.condition = .sunny

let rainyWeather = Weather()
rainyWeather.condition = .rainy

let ovalTrack = OvalTrack()
let circuitTrack = CircuitTrack()

let raceWithProDriver = Race(car: raceCar, driver: professionalDriver, trackLayout: ovalTrack, weather: sunnyWeather, pitStop: pitStop)
let raceWithAmateurDriver = Race(car: raceCar, driver: amateurDriver, trackLayout: circuitTrack, weather: rainyWeather, pitStop: pitStop)

raceWithProDriver.startRace()
raceWithAmateurDriver.startRace()
```

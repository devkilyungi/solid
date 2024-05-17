import Foundation

// Car class demonstrating SRP (Single Responsibility Principle).
// The Car class is responsible only for managing car properties and simple actions.
class Car {
    var speed: Double = 0.0
    var fuelLevel: Double = 100.0
    var tireCondition: Double = 100.0
    
    var aerodynamicConfig: AerodynamicConfig?
    var tireChoice: TireChoice?
    
    init() {}

    // Accelerate method demonstrates a single responsibility of accelerating the car.
    func accelerate() {
        speed += 10
        fuelLevel -= 1
        print("Car is accelerating. Speed: \(speed), Fuel Level: \(fuelLevel)")
    }

    // Brake method demonstrates a single responsibility of braking the car.
    func brake() {
        speed -= 10
        print("Car is braking. Speed: \(speed)")
    }

    // HandleTurn method demonstrates a single responsibility of handling a turn.
    func handleTurn() {
        tireCondition -= 5
        print("Car is turning. Tire Condition: \(tireCondition)")
    }
}

// OCP (Open-Closed Principle) is demonstrated here by defining protocols for aerodynamic and tire configurations.
// New configurations can be added without modifying existing code.
protocol AerodynamicConfig {
    func applyAerodynamics()
}

protocol TireChoice {
    func applyTires()
}

// Implementing specific aerodynamic configurations.
class LowDragConfig: AerodynamicConfig {
    func applyAerodynamics() {
        print("Applying low drag aerodynamics.")
    }
}

class HighDragConfig: AerodynamicConfig {
    func applyAerodynamics() {
        print("Applying high drag aerodynamics.")
    }
}

// Implementing specific tire choices.
class SoftTires: TireChoice {
    func applyTires() {
        print("Applying soft tires.")
    }
}

class MediumTires: TireChoice {
    func applyTires() {
        print("Applying medium tires.")
    }
}

class HardTires: TireChoice {
    func applyTires() {
        print("Applying hard tires.")
    }
}

// ISP (Interface Segregation Principle) is demonstrated by splitting the driver capabilities into smaller protocols.
protocol Acceleration {
    func accelerate()
}

protocol Braking {
    func brake()
}

protocol Cornering {
    func handleTurn()
}

// The Driver protocol inherits from smaller protocols, promoting ISP.
protocol Driver: Acceleration, Braking, Cornering {}

// Different driver implementations with their own logic.
class RecklessDriver: Acceleration, Braking {
    func accelerate() {
        print("Reckless driver is accelerating aggressively.")
    }

    func brake() {
        print("Reckless driver is braking aggressively.")
    }
}

class ProfessionalDriver: Driver {
    func accelerate() {
        print("Professional driver is accelerating smoothly.")
    }

    func brake() {
        print("Professional driver is braking smoothly.")
    }

    func handleTurn() {
        print("Professional driver is handling the turn expertly.")
    }
}

class AmateurDriver: Driver {
    func accelerate() {
        print("Amateur driver is accelerating cautiously.")
    }

    func brake() {
        print("Amateur driver is braking cautiously.")
    }

    func handleTurn() {
        print("Amateur driver is handling the turn cautiously.")
    }
}

// DIP (Dependency Inversion Principle) is demonstrated by depending on abstractions (Driver) instead of concrete classes.
class Race {
    private let car: Car
    private let driver: Driver
    private let trackLayout: TrackLayout
    private let weather: Weather
    private let pitStop: PitStop

    init(car: Car, driver: Driver, trackLayout: TrackLayout, weather: Weather, pitStop: PitStop) {
        self.car = car
        self.driver = driver
        self.trackLayout = trackLayout
        self.weather = weather
        self.pitStop = pitStop
    }

    func startRace() {
        print("Race is starting.")
        
        // Apply initial configurations
        car.aerodynamicConfig?.applyAerodynamics()
        car.tireChoice?.applyTires()

        // Simulate race actions with delays
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.driver.accelerate()
            self.trackLayout.applyLayoutEffects(to: self.car)
            self.weather.affectCarPerformance(car: self.car)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.driver.handleTurn()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            // Simulate a pit stop
            self.pitStop.performPitStop(for: self.car)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
            // Continue race actions
            self.driver.accelerate()
            self.trackLayout.applyLayoutEffects(to: self.car)
            self.weather.affectCarPerformance(car: self.car)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
            self.driver.brake()
            print("Race has ended.")
        }
    }
}

// PitStop class demonstrating SRP, handling only pit stop logic.
class PitStop {
    func performPitStop(for car: Car) {
        car.tireCondition = 100.0
        car.fuelLevel = 100.0
        print("Performed pit stop. Tire Condition: \(car.tireCondition), Fuel Level: \(car.fuelLevel)")
    }
}

// WeatherCondition enum and Weather class demonstrating SRP.
enum WeatherCondition {
    case sunny, rainy, cloudy
}

class Weather {
    var condition: WeatherCondition = .sunny

    func affectCarPerformance(car: Car) {
        switch condition {
        case .sunny:
            car.speed += 5
            print("Sunny weather: Car speed increased by 5. Speed: \(car.speed)")
        case .rainy:
            car.speed -= 10
            print("Rainy weather: Car speed decreased by 10. Speed: \(car.speed)")
        case .cloudy:
            print("Cloudy weather: Car speed remains the same. Speed: \(car.speed)")
        }
    }
}

// TrackLayout protocol for OCP, allowing new track layouts to be added without modifying existing code.
protocol TrackLayout {
    func applyLayoutEffects(to car: Car)
}

class OvalTrack: TrackLayout {
    func applyLayoutEffects(to car: Car) {
        car.speed += 10
        print("Oval track: Car speed increased by 10. Speed: \(car.speed)")
    }
}

class CircuitTrack: TrackLayout {
    func applyLayoutEffects(to car: Car) {
        car.speed -= 5
        print("Circuit track: Car speed decreased by 5. Speed: \(car.speed)")
    }
}

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

//
//  TemperatureStation.swift
//  TemperatureStation
//
//  Created by Riccardo Cipolleschi on 30/12/21.
//

import Foundation

class TemperatureStation {
  private var measurements: [String: [TemperatureMeasurement]] = [:]
  
  /// Function that inserts a new measurement if it is a new and it arrives at least one hour after the latest one
  /// - Parameter measurement: the measurement to add
  /// - Throws:
  ///   - `OutdatedMeasurement`: Whether there is a more resent measurement stored
  ///   - `TooRecentMeasurement`: Whether the measurement arrives earlier than one hour
  public func insert(measurement: TemperatureMeasurement) throws {    
    guard let last = self.measurements[measurement.city, default: []].last else {
      // the previousMeasurements for the given city is empty, I can insert the measurement easily
      self.append(measurement: measurement)
      return
    }
    
    guard measurement.timestamp > last.timestamp else {
      throw OutdatedMeasurement()
    }
    
    guard measurement.timestamp.distance(to: last.timestamp).magnitude > 3600 else {
      throw TooRecentMeasurement()
    }
    
    self.append(measurement: measurement)
  }
  
  /// Returns all the temperatures for a given city
  /// - Parameter city: the city to search
  /// - Returns: an array of TemperatureMeasurement, potentially empty.
  public func temperatures(for city: String) -> [TemperatureMeasurement] {
    return self.measurements[city, default: []]
  }
  
  /// Returns the most recent temperature for a given city
  /// - Parameter city: the city to search
  /// - Returns: a TemperatureMeasurement, if it exists
  public func mostRecentMeasurement(for city: String) -> TemperatureMeasurement? {
    return self.measurements[city]?.last
  }
  
  /// Return the list of cities
  public var cities: [String]  {
    return Array(self.measurements.keys)
  }
  
  /// Returns the average temperature of each city for the past 24 averages
  public var city24HAverage: [String: Double] {
    return self.measurements.mapValues { measures in
      let temps = measures.suffix(24)
      return temps.map(\.temperature).reduce(0.0, +) / Double(temps.count)
    }
    
  }
  
  // MARK: - Internal Details
  func append(measurement: TemperatureMeasurement) {
    self.measurements[measurement.city, default: []].append(measurement)
  }
}

// MARK: - Errors
extension TemperatureStation {
  struct OutdatedMeasurement: Error {}
  struct TooRecentMeasurement: Error {}
}

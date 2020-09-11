//
//  ContentView.swift
//  TemperatureConvertor
//
//  Created by Veselin Stefanov on 10.09.20.
//  Copyright © 2020 Veselin Stefanov. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    let temperatureMetrics = ["Celcius", "Fahrenheit", "Kelvin"]
    let temperatureMetricsSuffix = ["C", "F", "K"]
    
    @State private var selectedMetricInput = 0
    @State private var selectedMetricOutput = 1
    @State private var temperatureToConvert = ""
    
    private var convertedTemperature: Double{
        let temperatureToConvertValue = Double(temperatureToConvert) ?? 0
        
        /*
         C -> F = C * 1.8 + 32
         F -> C = (F - 32) / 1.8
         C -> K = C + 273.15
         K -> C = K - 273.15
         F -> K = (F + 459.67) * 5/9
         K -> F = K * 5/9 - 459.67
        */
        
        switch selectedMetricInput{
        case 0: // C
            return convertCelciusToOtherMetric(temperatureValueToConvert: temperatureToConvertValue, otherMetricIndex: selectedMetricOutput)
        case 1: // F
            return convertFahrenheitToOtherMetric(temperatureValueToConvert: temperatureToConvertValue, otherMetricIndex: selectedMetricOutput)
        case 2: // K
            return convertKelvinToOtherMetric(temperatureValueToConvert: temperatureToConvertValue, otherMetricIndex: selectedMetricOutput)
        default:
            return 0
        }
    }
    
    private func convertCelciusToOtherMetric(temperatureValueToConvert: Double, otherMetricIndex: Int) -> Double{
        
        switch otherMetricIndex{
        case 0: // C
            return temperatureValueToConvert
        case 1: // F
            return temperatureValueToConvert * 1.8 + 32.0
        case 2: // K
            return temperatureValueToConvert + 273.15
        default:
            return 0
        }
    }
    
    private func convertFahrenheitToOtherMetric(temperatureValueToConvert: Double, otherMetricIndex: Int) -> Double{
        
        switch otherMetricIndex{
        case 0: // C
            return (temperatureValueToConvert - 32.0) / 1.8
        case 1: // F
            return temperatureValueToConvert
        case 2: // K
            return (temperatureValueToConvert + 459.67) * (5.0/9.0)
        default:
            return 0
        }
    }
    
    private func convertKelvinToOtherMetric(temperatureValueToConvert: Double, otherMetricIndex: Int) -> Double{
        
        switch otherMetricIndex{
        case 0: // C
            return temperatureValueToConvert - 273.15
        case 1: // F
            return (temperatureValueToConvert * (9.0/5.0)) - 459.67
        case 2: // K
            return temperatureValueToConvert
        default:
            return 0
        }
    }
    
    var body: some View {
        Form{
            Section(header: Text("Input metric")){
                Picker("test", selection: $selectedMetricInput){
                    ForEach(0 ..< temperatureMetrics.count){
                        Text("\(self.temperatureMetrics[$0])")
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                
                TextField("Temperature", text: $temperatureToConvert)
                    .keyboardType(.decimalPad)
            }
            
            Section(header: Text("Output metric")){
                Picker("test", selection: $selectedMetricOutput){
                    ForEach(0 ..< temperatureMetrics.count){
                        Text("\(self.temperatureMetrics[$0])")
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                
                Text("\(self.convertedTemperature, specifier: "%.2f") \(self.temperatureMetricsSuffix[self.selectedMetricOutput])")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

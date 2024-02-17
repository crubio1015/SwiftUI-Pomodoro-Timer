//
//  ContentView.swift
//  project12
//
//  Created by Christian Rubio on 2/17/24.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct PomodoroTimerView: View {
    @State private var studyTimeInput: String = "25"
    @State private var breakTimeInput: String = "5"
    @State private var timeRemaining = 25 * 60 // 25 minutes in seconds
    @State private var timerActive = false
    @State private var onBreak = false
    @State private var timer: Timer?

    var body: some View {
        VStack(spacing: 20) {
             TextField("Study Time (minutes)", text: $studyTimeInput)
                 .textFieldStyle(RoundedBorderTextFieldStyle())
                 .keyboardType(.numberPad)
                 .padding()

             TextField("Break Time (minutes)", text: $breakTimeInput)
                 .textFieldStyle(RoundedBorderTextFieldStyle())
                 .keyboardType(.numberPad)
                 .padding()

             Text(timeString(time: timeRemaining))
                 .font(.largeTitle)

             Button(action: {
                 self.startOrPauseTimer()
             }) {
                 Text(timerActive ? "Pause" : "Start")
             }
         }
         .onAppear() {
             // Initialize timer with default or previously entered values
             updateTimerDuration()
         }
    }
    func updateTimerDuration() {
            if !timerActive { // Update duration only when timer is not active
                let studyMinutes = Int(studyTimeInput) ?? 25 // Use default if input is not a number
                timeRemaining = studyMinutes * 60 // Convert minutes to seconds
            }
                
        }


    // Converts the time remaining into a formatted string
    func timeString(time: Int) -> String {
        let minutes = time / 60
        let seconds = time % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }

    // Start or pause the timer
    func startOrPauseTimer() {
        if timerActive {
            // Stop the timer
            timer?.invalidate()
            timerActive = false
        } else {
            // Start or resume the timer
            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                // Check if timeRemaining > 0, decrement it
                if self.timeRemaining > 0 {
                    self.timeRemaining -= 1
                } else {
                    // Time is up, switch modes
                    self.switchModes()
                }
            }
            if let timer = timer {
                RunLoop.current.add(timer, forMode: .common)
            }
            timerActive = true
        }
    }

    // Switch between work and break modes
    func switchModes() {
            timer?.invalidate() // Stop current timer before switching modes
            if onBreak {
                // If it was on break, switch to study time
                let studyMinutes = Int(studyTimeInput) ?? 25
                timeRemaining = studyMinutes * 60
                onBreak = false
            } else {
                // If it was on study time, switch to break time
                let breakMinutes = Int(breakTimeInput) ?? 5
                timeRemaining = breakMinutes * 60
                onBreak = true
            }
            // Restart the timer with the new duration
            startOrPauseTimer()
        }
}




struct ContentView: View {
    
    @State private var showImmersiveSpace = false
    @State private var immersiveSpaceIsShown = false
    @Environment(\.openImmersiveSpace) var openImmersiveSpace
    @Environment(\.dismissImmersiveSpace) var dismissImmersiveSpace
    
    var body: some View {
        
        NavigationSplitView{
            List{
                Text("Clock")
            }
            .navigationTitle("Home")
        }detail: {
            VStack{
                PomodoroTimerView()
            }
            .navigationTitle("Clock")
            .padding()
        }
        
    }
}
    
    #Preview(windowStyle: .automatic) {
        ContentView()
    }


//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Henry Pendleton on 3/11/24.
//

import SwiftUI

struct FlagImage: View {
    var country: String
    var body: some View{
        Image(country)
            .clipShape(.capsule)
            .shadow(radius: 5)
    }
}

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    
    
    @State private var showingAlert = false
    var body: some View {
        ZStack{
            LinearGradient(colors:[.blue, .black], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            VStack(spacing: 30){
                VStack{
                    Text("Tap then Flag of")
                        .foregroundStyle(.white)
                        .font(.subheadline.weight(.semibold))
                    Text(countries[correctAnswer])
                        .foregroundStyle(.white)
                        .font(.largeTitle.weight(.semibold))
                    
                }
                ForEach(0..<3){ number in
                    Button{
                        flagTapped(num: number)
                    } label: {
                        FlagImage(country: countries[number])
                    }
                }
            }
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("You Score is ???")
        }
    }
    
    func flagTapped(num:Int){
        if num == correctAnswer{
            scoreTitle = "Correct"
        } else {
            scoreTitle = "Wrong"
        }
        
        showingScore = true
    }
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}



#Preview {
    ContentView()
}


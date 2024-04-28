//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Brian Vo on 4/26/24.
//

import SwiftUI

struct flagImage : View{
    var image : String
    var body: some View{
        Image(image)
            .clipShape(.capsule)
            .shadow(radius: 5)
            
        
    }
    
}

struct Title: ViewModifier{
    func body(content: Content) -> some View {
        content
        .font(.largeTitle)
        .foregroundColor(.blue)
    }
}
extension View{
    func titleStyle() ->some View{
        modifier(Title())
    }
}


struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State private var correctAnswer = Int.random(in:0...2)
    @State private var scoreMessage = ""
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    
    @State private var endGame = false
    
    @State private var score = 0
    
    @State private var totalQuestions = 0
    
    var body: some View {
        
        ZStack{
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.5), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 700)
                .ignoresSafeArea()
            
            VStack{
                
                Spacer()
                
                Text("Guess the flag")
//                    .titleStyle()
                    .font(.largeTitle.bold())
                    .foregroundStyle(.white)
                
                
                
                VStack(spacing:15){
                    
                    VStack{
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3){ number in
                        Button{
                            flagTapped(number)
                        }label: {
                            flagImage(image: countries[number])
                                
                        }
                        
                    }
                    
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                Text("Score \(score)")
                    .foregroundStyle(.white)
                    .font(.largeTitle.bold())
                
                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore){
            Button("Continue", action: askQuestion)
        }message: {
            Text(scoreMessage)
        }
        .alert(scoreTitle, isPresented: $endGame){
            Button("Restart", action: askQuestion)
        }message:{
            Text(scoreMessage)
        }
    }
    
    func flagTapped(_ number : Int){
        if number == correctAnswer{
            scoreTitle = "Correct"
            score += 1
            scoreMessage = "Your score is \(score)"
        }
        else{
            scoreTitle = "Wrong"
            //score = 0
            scoreMessage = "Wrong that's the \(countries[number]) flag"
        }
        showingScore = true
        
    }
    
    func askQuestion(){
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        totalQuestions += 1
        
        if(totalQuestions == 8){
            endGame = true
            scoreTitle = "Game Over"
            scoreMessage = "\(score)/8"
            score = 0
            
        }
        
        
        
    }
    
}

#Preview {
    ContentView()
}

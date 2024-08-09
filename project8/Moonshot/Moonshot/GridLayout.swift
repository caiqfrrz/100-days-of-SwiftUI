//
//  GridLayout.swift
//  Moonshot
//
//  Created by Caique Ferraz on 08/08/24.
//

import SwiftUI

struct GridLayout: View {
    let missions: [Mission]
    let astronauts: [String: Astronaut]
    
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(missions) { mission in
                    NavigationLink(value: mission) {
                        //MissionView(mission: mission, astronauts: astronauts)
                        VStack {
                            Image(mission.image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                                .padding()
                            
                            VStack {
                                Text(mission.displayName)
                                    .font(.headline)
                                    .foregroundStyle(.white)
                                
                                Text(mission.formattedLaunchDate)
                                    .font(.caption)
                                    .foregroundStyle(.gray)
                            }
                            .padding(.vertical)
                            .frame(maxWidth: .infinity)
                            .background(.lightBackground)
                        }
                        .clipShape(.rect(cornerRadius: 10))
                        .overlay (
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.lightBackground)
                            
                        )
                        .shadow(radius: 5)
                    }
                }
            }
            .padding([.horizontal, .bottom])
            
        }
        .navigationTitle("Moonshot")
        .background(LinearGradient(colors: [.darkBackground, Color(red: 0.4, green: 0.4, blue: 0.6)], startPoint: .top, endPoint: .bottom))
        .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
        .navigationDestination(for: Mission.self) { selected in
            MissionView(mission: selected, astronauts: astronauts)
        }
        
    }
}

#Preview {
    let mission: [Mission] = Bundle.main.decode("missions.json")
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    
    return GridLayout(missions: mission, astronauts: astronauts)
        .preferredColorScheme(.dark)
}


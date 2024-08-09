//
//  ListLayout.swift
//  Moonshot
//
//  Created by Caique Ferraz on 08/08/24.
//

import SwiftUI

struct ListLayout: View {
    let missions: [Mission]
    let astronauts: [String: Astronaut]
    
    var body: some View {
        List {
            ForEach(missions){ mission in
                NavigationLink(value: mission) {
                    //MissionView(mission: mission, astronauts: astronauts)
                    VStack(alignment: .leading) {
                        
                        HStack {
                            Image(mission.image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 70, height: 70)
                            
                            
                            VStack(alignment: .leading) {
                                Text(mission.displayName)
                                    .fontWeight(.bold)
                                    .foregroundStyle(.white)
                                
                                Text(mission.formattedLaunchDate)
                                    .foregroundStyle(.white.opacity(0.6))
                            }
                            .padding(.leading, 10)
                        }
                    }
                }
            }
            .listRowBackground(Color.darkBackground)
        }
        .navigationTitle("Moonshot")
        .listStyle(.plain)
        .listRowSeparator(.visible)
        .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
        .background(.darkBackground)
        .navigationDestination(for: Mission.self) { selected in
            MissionView(mission: selected, astronauts: astronauts)
        }
    }
}

#Preview {
    let mission: [Mission] = Bundle.main.decode("missions.json")
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    
    return ListLayout(missions: mission, astronauts: astronauts)
        .preferredColorScheme(.dark)
}

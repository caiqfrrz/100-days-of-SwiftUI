//
//  MissionView.swift
//  Moonshot
//
//  Created by Caique Ferraz on 06/08/24.
//

import SwiftUI

struct MissionView: View {
    struct CrewMember: Hashable {
        let role: String
        let astronaut: Astronaut
    }
    
    let mission: Mission
    let crew: [CrewMember]
    
    var body: some View {
        ScrollView {
            VStack {
                Image(mission.image)
                    .resizable()
                    .scaledToFit()
                    .containerRelativeFrame(.horizontal) { width, axis in
                        width * 0.6
                    }
                    .padding(.top)
                
                Text(mission.formattedLaunchDateComplete)
                    .padding(.top)
                    .foregroundStyle(.secondary)
                
                
                VStack(alignment: .leading) {
                    Rectangle()
                        .frame(height: 3)
                        .opacity(0.1)
                        .padding(.vertical)
                    
                    Text("Mission Highlights")
                        .font(.title.bold())
                        .padding(.bottom, 5)
                    
                    Text(mission.description)
                    
                    Rectangle()
                        .frame(height: 3)
                        .opacity(0.1)
                        .padding(.vertical)
                    
                    Text("Crew")
                        .font(.title.bold())
                    
                }
                .padding(.horizontal)

                CrewScrollView(crew: crew)
                
            }
            .padding(.bottom)
        }
        .navigationTitle(mission.displayName)
        .navigationBarTitleDisplayMode(.inline)
        .background(LinearGradient(colors: [.darkBackground, Color(red: 0.4, green: 0.4, blue: 0.6)], startPoint: .top, endPoint: .bottom))
    }
    
    init(mission: Mission, astronauts: [String: Astronaut]) {
        self.mission = mission
        
        self.crew = mission.crew.map { member in
            if let astronaut = astronauts[member.name] {
                CrewMember(role: member.role, astronaut: astronaut)
            } else {
                fatalError("Missing \(member.name)")
            }
        }
    }
}

#Preview {
    let mission: [Mission] = Bundle.main.decode("missions.json")
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    
    return MissionView(mission: mission[0], astronauts: astronauts)
        .preferredColorScheme(.dark)
}

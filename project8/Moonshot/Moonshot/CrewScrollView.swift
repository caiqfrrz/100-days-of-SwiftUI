//
//  CrewScrollView.swift
//  Moonshot
//
//  Created by Caique Ferraz on 08/08/24.
//

import SwiftUI

struct CrewScrollView: View {
    
    let crew: [MissionView.CrewMember]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(crew, id: \.role) { member in
                    NavigationLink {
                        AstronautView(astronaut: member.astronaut)
                    } label: {
                        HStack {
                            Image(member.astronaut.id)
                                .resizable()
                                .frame(width: 104, height: 72)
                                .clipShape(.capsule)
                                .overlay(
                                    Capsule()
                                        .stroke(.white, lineWidth: 1.5)
                                )
                            
                            VStack(alignment: .leading){
                                Text(member.astronaut.name)
                                    .foregroundStyle(.white)
                                    .fontWeight(.bold)
                                
                                Text(member.role)
                                    .foregroundStyle(.white.opacity(0.5))
                            }
                            .padding(.trailing)

                        }
                    }
                }
            }
        }
    }
}

#Preview {
    let missions: [Mission] = Bundle.main.decode("missions.json")
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let mission = missions[0]
    
    let crew = mission.crew.map { member in
        if let astronaut = astronauts[member.name] {
            MissionView.CrewMember(role: member.role, astronaut: astronaut)
        } else {
            fatalError("Missing \(member.name)")
        }
    }
    
    return CrewScrollView(crew: crew)
        .preferredColorScheme(.dark)
}

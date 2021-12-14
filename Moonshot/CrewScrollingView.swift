//
//  AstronautsView.swift
//  Moonshot
//
//  Created by Victor Colen on 14/12/21.
//

import SwiftUI

struct CrewScrollingView: View {    
    let mission: Mission
    let crew: [CrewMember]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(crew, id: \.role) { crewMember in
                    NavigationLink {
                        AstronautView(astronaut: crewMember.astronaut)
                    } label: {
                        HStack {
                            VStack {
                            Image(crewMember.astronaut.id)
                                .resizable()
                                .clipShape(Circle())
                                .frame(width: 200, height: 150)
                                .padding(.horizontal)
                                .overlay {
                                    Circle()
                                        .strokeBorder(crewMember.role == "Commander" ? .yellow : .white, lineWidth: 3)
                                }
                            
                                Text(crewMember.astronaut.name)
                                    .font(.headline)
                                    .foregroundColor(.white)
                                Text(crewMember.role)
                                    .foregroundColor(crewMember.role == "Commander" ? .primary : .secondary)
                            }
                        }
                        .padding(.top)
                    }
                }
            }
        }
    }
}

struct AstronautsScrollingView_Previews: PreviewProvider {
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    static let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    static let crew = missions[0].crew.map { member -> CrewMember in
        if let astronaut = astronauts[member.name] {
            return CrewMember(role: member.role, astronaut: astronaut)
        } else {
            fatalError("Missing \(member.name).")
        }
    }
    
    static var previews: some View {
        CrewScrollingView(mission: missions[1], crew: crew)
    }
}

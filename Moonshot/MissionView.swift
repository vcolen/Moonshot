//
//  MissionView.swift
//  Moonshot
//
//  Created by Victor Colen on 12/12/21.
//

import SwiftUI

struct MissionView: View {
    @State private var rotationAmount = 0.0
    
    let mission: Mission
    let crew: [CrewMember]
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack {
                    Image(mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: geometry.size.width * 0.58)
                        .padding(.top)
                        .rotation3DEffect(.degrees(rotationAmount), axis: (x: 0, y: 1, z: 0))
                        .onAppear {
                            withAnimation {
                                rotationAmount += 360
                            }
                        }
                    
                    Text(mission.launchDate?.formatted(date: .complete, time: .omitted) ?? "N/A")
                        .padding()
                        .font(.headline)
                    
                    VStack(alignment: .leading) {
                        Text("Mission Highlights")
                            .font(.title.bold())
                            .padding([.bottom, .top], 10)
                        
                        Text(mission.description)
                        
                        Text("Heroes")
                            .font(.title.bold())
                            .padding([.bottom, .top], 10)
                    }
                    .padding(.horizontal)
                    
                    CrewScrollingView(mission: mission, crew: crew)
                }
                .padding(.bottom)
            }
        }
        .navigationTitle(mission.displayName)
        .navigationBarTitleDisplayMode(.inline)
        .background(.darkBackground)
    }
    
    init(mission: Mission, astronauts: [String: Astronaut]) {
        self.mission = mission
        
        self.crew = mission.crew.map { member in
            if let astronaut = astronauts[member.name] {
                return CrewMember(role: member.role, astronaut: astronaut)
            } else {
                fatalError("Missing \(member.name).")
            }
        }
    }
}

struct MissionView_Previews: PreviewProvider {
    
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    static let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    
    static var previews: some View {
        MissionView(mission: missions[1], astronauts: astronauts)
            .preferredColorScheme(.dark)
    }
}

//
//  ScrumsView.swift
//  Scrumdinger
//
//  Created by Apple on 21.09.2023.
//

import SwiftUI

struct ScrumsView: View {
    
    @Environment(\.scenePhase) private var scenePhase
    
    @Binding var scrums: [DailyScrum]
    
    @State private var isPresentingNewScrumView = false
    
    let saveAction: ()->Void
    
    var body: some View {
        NavigationStack{
            List($scrums){ $scrum in
                NavigationLink(destination: DetailView(scrum: $scrum)){
                    CardView(scrum: scrum)
                }
                .listRowBackground(scrum.theme.mainColor)
            }
            .navigationTitle("Daily Scrums")
            .toolbar{
                Button(action: {
                    isPresentingNewScrumView = true
                }){
                    Image(systemName: "plus")
                }
                .accessibilityLabel("New Scrum")
            }
        }
        .sheet(isPresented: $isPresentingNewScrumView){
            NewScrumSheet(scrums: $scrums, isPresentingNewScrumView: $isPresentingNewScrumView)
        }
        .onChange(of: scenePhase) { phase in
            if phase == .inactive { saveAction() }
        }
    }
}

struct ScrumsView_Previews: PreviewProvider {
    static var previews: some View {
        ScrumsView(scrums: .constant(DailyScrum.sampleData), saveAction: {})
    }
}

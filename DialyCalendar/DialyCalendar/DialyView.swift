//
//  DialyView.swift
//  DialyCalendar
//
//  Created by いーま on 2022/09/25.
//

import SwiftUI
import FirebaseFirestore

struct DialyView: View {
    
//    @Environment(\.dismiss) var dismiss
    @Environment(\.presentationMode) var presentation
    @EnvironmentObject var appState:AppState
    
    
    var body: some View {
        NavigationView{
            Text(appState.dialy[0])
                .toolbar{
                    NavigationLink{
                        AddDialyView()
                    }label: {
                        Text(Image(systemName: "plus"))
                    }
                }
                .navigationTitle(appState.chooseDate)
        }
    }
}

//
//  DialyView.swift
//  DialyCalendar
//
//  Created by いーま on 2022/09/25.
//

import SwiftUI
import FirebaseFirestore

struct DiaryView: View {
    
//    @Environment(\.dismiss) var dismiss
    @Environment(\.presentationMode) var presentation
    @EnvironmentObject var appState:AppState
    
    
    var body: some View {
        NavigationView{
            Text(appState.diary[0])
                .toolbar{
                    NavigationLink{
                        AddDiaryView()
                    }label: {
                        Text(Image(systemName: "plus"))
                    }
                }
                .navigationTitle(appState.chooseDate)
        }
    }
}

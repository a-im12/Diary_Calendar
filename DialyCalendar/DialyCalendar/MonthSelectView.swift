//
//  MonthSelectView.swift
//  DialyCalendar
//
//  Created by いーま on 2022/09/25.
//

import SwiftUI
import FirebaseAuth

struct MonthSelectView: View {
    
    var userAuth = UserAuth()
    @EnvironmentObject var appState:AppState
    
    @State var num:Int = 0
    var body: some View {
        NavigationView{
            VStack {
                if let targetMonth = Calendar.current.date(byAdding: .month, value: num, to: Date()) {
                    
                    HStack{
                        Button(action: {
                            num -= 1
                        }){
                            Image(systemName: "lessthan")
                        }
                        
                        Text(String((Calendar.current.component(.year, from: targetMonth))) + " / \(Calendar.current.component(.month, from: targetMonth))")
                        
                        Button(action: {
                            num += 1
                        }){
                            Image(systemName: "greaterthan")
                        }
                    }
                    CalendarView(selectMonth: targetMonth)
                }
            }
            .navigationTitle("Dialy Calendar")
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing){
                    Button(action:{
                        do {
                            try Auth.auth().signOut()
                            defer{appState.isLogin = false}
                            defer{appState.uid = ""}
                        } catch let signOutError as NSError {
                            print("Error signing out: %@", signOutError)
                        }
                    }){
                        Text("Log Out")
                    }
                }
            }
        }
    }
}

struct MonthSelectView_Previews: PreviewProvider {
    static var previews: some View {
        MonthSelectView()
    }
}

//
//  RouteView.swift
//  DialyCalendar
//
//  Created by いーま on 2022/09/25.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct RouteView: View {
    
    @EnvironmentObject var appState:AppState
    var db = Firestore.firestore()
    var userInfo:UserInfo = UserInfo()
    
    var body: some View {
        if Auth.auth().currentUser != nil{
            MonthSelectView()
        }
        else{
            ContentView()
        }
    }
}

struct RouteView_Previews: PreviewProvider {
    static var previews: some View {
        RouteView()
    }
}


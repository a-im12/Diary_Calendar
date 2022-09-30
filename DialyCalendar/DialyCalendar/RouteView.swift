//
//  RouteView.swift
//  DialyCalendar
//
//  Created by いーま on 2022/09/25.
//

import SwiftUI

struct RouteView: View {
    
    @EnvironmentObject var appState:AppState
    
    var body: some View {
        if appState.isLogin{
            MonthSelectView()
        }else{
            ContentView()
        }
    }
}

struct RouteView_Previews: PreviewProvider {
    static var previews: some View {
        RouteView()
    }
}

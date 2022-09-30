//
//  AppState.swift
//  DialyCalendar
//
//  Created by いーま on 2022/09/25.
//

import Foundation
import SwiftUI

class AppState: ObservableObject {
    @Published var isLogin:Bool = false
    @Published var path = NavigationPath()
    @Published var chooseDate:String = ""
    @Published var dialy:[String] = ["Please add a dialy..."]
    @Published var separatedByUnderBar:String = ""
    @Published var uid:String = ""
}

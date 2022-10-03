//
//  CalendarView.swift
//  DialyCalendar
//
//  Created by いーま on 2022/09/25.
//

import SwiftUI
import FirebaseFirestore
import FirebaseAuth

struct CalendarView: View {
    
    let db = Firestore.firestore().collection("users")
    var selectMonth:Date
    @EnvironmentObject var appState:AppState
    @State var isShowingView:Bool = false
    
    var body: some View {
        let dates = selectMonth.getDaysForMonth()
        
        LazyVGrid(columns: Array(repeating: GridItem(), count: 7)){
            ForEach(["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"], id: \.self){ weekdayName in
                Text(weekdayName)
            }
            
            ForEach(dates, id:\.self){ date in
                
                if Calendar.current.component(.month, from: date) == Calendar.current.component(.month, from: selectMonth){
                    if Calendar.current.component(.day, from: date) == Calendar.current.component(.day, from: Date()) && Calendar.current.component(.month, from: date) == Calendar.current.component(.month, from: Date()){
                        
                        Button("\(date.getDateNumber())"){
                            
                            appState.chooseDate = String(Calendar.current.component(.year, from: date)) + "/\(Calendar.current.component(.month, from: date))/\(Calendar.current.component(.day, from: date))"
                            
                            appState.separatedByUnderBar = String(Calendar.current.component(.year, from: date)) + "_\(Calendar.current.component(.month, from: date))_\(Calendar.current.component(.day, from: date))"
                            
                            appState.dialy = ["Please add a dialy..."]
                            
                            if let user = Auth.auth().currentUser{
                                
                                db.document(user.uid).collection("dialy").whereField("date", isEqualTo: appState.separatedByUnderBar).getDocuments(){ (querySnapshot, error) in
                                    if let error = error{
                                        print(error)
                                        return
                                    }else{
                                        for document in querySnapshot!.documents{
                                            guard let content = document.get("content") as? String else {
                                                continue
                                            }
                                            appState.dialy[0] = content
                                        }
                                    }
                                }
                                isShowingView.toggle()
                            }
                        }
                        .padding(8)
                        .foregroundColor(.white)
                        .frame(width: 50, height: 50)
                        .background(Color.orange)
                        .cornerRadius(10)
                    }else{
                        Button("\(date.getDateNumber())"){
                            
                            appState.chooseDate = String(Calendar.current.component(.year, from: date)) + "/\(Calendar.current.component(.month, from: date))/\(Calendar.current.component(.day, from: date))"
                            
                            appState.separatedByUnderBar = String(Calendar.current.component(.year, from: date)) + "_\(Calendar.current.component(.month, from: date))_\(Calendar.current.component(.day, from: date))"
                            
                            appState.dialy = ["Please add a dialy..."]
                            
                            if let user = Auth.auth().currentUser{
                                
                                db.document(user.uid).collection("dialy").whereField("date", isEqualTo: appState.separatedByUnderBar).getDocuments(){ (querySnapshot, error) in
                                    if let error = error{
                                        print(error)
                                        return
                                    }else{
                                        for document in querySnapshot!.documents{
                                            guard let content = document.get("content") as? String else {
                                                continue
                                            }
                                            appState.dialy[0] = content
                                        }
                                    }
                                }
                                isShowingView.toggle()
                            }
                        }
                        .padding(8)
                        .foregroundColor(.white)
                        .frame(width: 50, height: 50)
                        .background(Color.gray)
                        .cornerRadius(10)
                    }
                }else{
                    Text("\(date.getDateNumber())")
                        .padding(8)
                        .frame(width: 50, height: 50)
                        .background(Color.clear)
                        .cornerRadius(10)
                }
            }
            .sheet(isPresented: $isShowingView){
                DialyView()
            }
        }
    }
}

//struct CalendarView_Previews: PreviewProvider {
//    static var previews: some View {
//        CalendarView(monthToDisplay: <#Date#>)
//    }
//}

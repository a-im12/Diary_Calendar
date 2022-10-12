//
//  AddDialyView.swift
//  DialyCalendar
//
//  Created by いーま on 2022/09/27.
//

import SwiftUI
import FirebaseFirestore
import FirebaseAuth

struct AddDiaryView: View {
    
    @EnvironmentObject var appState:AppState
    @Environment(\.dismiss) var dissmiss
    @State var diary:String = ""
    @State var errorMessage:String = ""
    @State var isShowingAleart:Bool = false

    var db = Firestore.firestore().collection("users")

    var body: some View {
        VStack{
            Text("add Diary")
                .font(.title)
            Spacer()
            
            TextField("I had lunch with my friend", text: $diary)
                .padding(20)
            
            Button("add diary !"){
                
                if diary != ""{
                    
                    if let user = Auth.auth().currentUser{
                        db.document(user.uid).collection("diary")
                            .document(appState.separatedByUnderBar)
                            .getDocument(){(document, error) in
                                
                                if let document = document{
                                    
                                    if document.exists{
                                        db.document(user.uid).collection("diary")
                                            .document(appState.separatedByUnderBar)
                                            .updateData([
                                                "content" : diary
                                            ])
                                    }else{
                                        db.document(user.uid).collection("diary")
                                            .document(appState.separatedByUnderBar)
                                            .setData([
                                                "date" : appState.separatedByUnderBar,
                                                "content" : diary
                                            ])
                                    }
                                }
                            }
                        appState.diary[0] = diary
                        dissmiss()
                    }
                }else{
                    errorMessage = "1文字以上入力してください"
                    isShowingAleart = true
                }
            }
            .foregroundColor(.white)
            .frame(width: 120, height: 50)
            .background(Color.blue)
            .cornerRadius(10)
            .alert(isPresented: $isShowingAleart){
                Alert(title: Text("入力エラー"), message: Text(errorMessage))
            }
            Spacer()
        }
        .navigationBarBackButtonHidden(true)
        .toolbar{
            ToolbarItem(placement: .navigationBarLeading){
                Button("Back"){
                    dissmiss()
                }
            }
        }
    }
}

//struct AddDiaryView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddDiaryView()
//    }
//}

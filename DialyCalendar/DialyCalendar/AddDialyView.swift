//
//  AddDialyView.swift
//  DialyCalendar
//
//  Created by いーま on 2022/09/27.
//

import SwiftUI
import FirebaseFirestore
import FirebaseAuth

struct AddDialyView: View {
    
    @EnvironmentObject var appState:AppState
    @Environment(\.dismiss) var dissmiss
    @State var dialy:String = ""
    @State var errorMessage:String = ""
    @State var isShowingAleart:Bool = false

    var db = Firestore.firestore().collection("users")

    var body: some View {
        VStack{
            Text("add Dialy")
                .font(.title)
            Spacer()
            
            TextField("I had lunch with my friend", text: $dialy)
                .padding(20)
            
            Button("add dialy !"){
                
                if dialy != ""{
                    
                    if let user = Auth.auth().currentUser{
                        db.document(user.uid).collection("dialy")
                            .document(appState.separatedByUnderBar)
                            .getDocument(){(document, error) in
                                
                                if let document = document{
                                    
                                    if document.exists{
                                        db.document(user.uid).collection("dialy")
                                            .document(appState.separatedByUnderBar)
                                            .updateData([
                                                "content" : dialy
                                            ])
                                    }else{
                                        db.document(user.uid).collection("dialy")
                                            .document(appState.separatedByUnderBar)
                                            .setData([
                                                "date" : appState.separatedByUnderBar,
                                                "content" : dialy
                                            ])
                                    }
                                }
                            }
                        appState.dialy[0] = dialy
                        dissmiss()
                    }
                }else{
                    errorMessage = "1文字以上入力してください"
                    isShowingAleart = true
                }
            }
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

//struct AddDialy_Previews: PreviewProvider {
//    static var previews: some View {
//        AddDialyView()
//    }
//}

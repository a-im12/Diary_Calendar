//
//  SignupView.swift
//  DialyCalendar
//
//  Created by いーま on 2022/09/25.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct SignupView: View {
    
    @EnvironmentObject var appState:AppState
    
    let userAuth:UserAuth = UserAuth()
    let userInfo:UserInfo = UserInfo()
    let db = Firestore.firestore()
    
    @State var email:String = ""
    @State var pass:String = ""
    @State var errorMessage:String = ""
    @State var isShowingAlert:Bool = false
    
    var body: some View {
        VStack{
            Text("Sign Up")
                .padding()
            TextField("mailadress", text: $email)
                .padding()
            TextField("password", text: $pass)
                .padding()
            
            Button(action:{
                
                errorMessage = userInfo.checkEntry(email: email, pass: pass)
                
                if errorMessage == ""{
                    Auth.auth().createUser(withEmail: email, password: pass) { (authResult, error)in
                        guard authResult?.user != nil else{
                            print("登録できません")
                            self.errorMessage = "このメールアドレスは登録できません。\n別のメールアドレスをお試しください。"
                            self.isShowingAlert = true
                            return
                        }
                        if let user = Auth.auth().currentUser{
                            userAuth.accessUserDB(uid: user.uid, email: user.email ?? "")
                        }
                        self.appState.path.removeLast()
                    }
                }else{
                    isShowingAlert = true
                }
            }){
                Text("Sign Up!")
                    .foregroundColor(.white)
                    .frame(width: 120, height: 50)
                    .background(Color.blue)
                    .cornerRadius(10)
                    .alert(isPresented: $isShowingAlert){
                        Alert(title: Text("登録失敗"), message: Text(errorMessage))
                    }
            }
        }
    }
}

struct SignupView_Previews: PreviewProvider {
    static var previews: some View {
        SignupView()
    }
}

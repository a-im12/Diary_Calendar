//
//  SignupView.swift
//  DialyCalendar
//
//  Created by いーま on 2022/09/25.
//

import SwiftUI
import FirebaseAuth

struct SignupView: View {
    
    let userAuth:UserAuth = UserAuth()
    
    @EnvironmentObject var appState:AppState
    
    let userInfo:UserInfo = UserInfo()
    
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
                        self.appState.path.removeLast()
                    }
                }else{
                    isShowingAlert = true
                }
            }){
                Text("Sign In!")
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

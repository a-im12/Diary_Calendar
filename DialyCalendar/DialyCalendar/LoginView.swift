//
//  LoginView.swift
//  DialyCalendar
//
//  Created by いーま on 2022/09/25.
//

import SwiftUI
import FirebaseAuth

struct LoginView: View {
    
    @EnvironmentObject var appState:AppState
    
    var userInfo = UserInfo()
    var userAuth = UserAuth()
    
    @State var email = ""
    @State var pass = ""
    @State var uid:String = ""
    @State var errorMessage:String = ""
    @State var isShowingAlert:Bool = false
    
    var body: some View {
        NavigationView{
            VStack{
                Text("Log In")
                    .padding()
                TextField("mailaddress", text: $email)
                    .padding()
                TextField("password", text: $pass)
                    .padding()
                Button(action:{
                    errorMessage = userInfo.checkEntry(email: email, pass: pass)
                                        
                    if errorMessage == ""{
                        
                        Auth.auth().signIn(withEmail: email, password: pass) {(authResult, error) in
                            guard authResult?.user != nil else{
                                errorMessage = "ユーザ情報が確認できません"
                                isShowingAlert = true
                                return
                            }
                            if let user = authResult?.user{
                                uid = user.uid
                                email = user.email ?? ""
                                                                
                                userAuth.accessUserDB(uid: uid, email: email)
                                
                                self.appState.uid = uid
                                // 画面遷移するために変換
                                self.appState.isLogin = true
                                self.appState.path.append("Route")
                            }
                        }
                    }else{
                        isShowingAlert = true
                    }
                }){
                    Text("ログイン")
                        .alert(isPresented: $isShowingAlert){
                            Alert(title: Text("ログインエラー"), message: Text(errorMessage))
                        }
                }
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

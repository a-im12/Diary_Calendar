//
//  ContentView.swift
//  DialyCalendar
//
//  Created by いーま on 2022/09/24.
//

import SwiftUI
import FirebaseAuth

struct ContentView: View {
    
    @EnvironmentObject var appState:AppState
    @State var email = ""
    @State var pass = ""
    @State var uid:String = ""
    @State var errorMessage:String = ""
    @State var isShowingAlert:Bool = false
    
    var userInfo = UserInfo()
    var userAuth = UserAuth()
    
    var body: some View {
        NavigationStack(path:$appState.path){
            Text("Welcome")
                .padding(20)
                .font(.title)
            TextField("mailaddress", text: $email)
                .padding()
            TextField("password", text: $pass)
                .padding()
            Button("Log In"){
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
                            
//                            self.appState.uid = uid
                            // 画面遷移するために変換
//                            self.appState.isLogin = true
                            self.appState.path.append("Route")
                        }
                    }
                }else{
                    isShowingAlert = true
                }
            }
            .foregroundColor(.white)
            .frame(width: 120, height: 50)
            .background(Color.blue)
            .cornerRadius(10)
            .alert(isPresented: $isShowingAlert){
                Alert(title: Text("ログインエラー"), message: Text(errorMessage))
            }
            .padding()
            
            Button("create new account !!"){
                appState.path.append("signup")
            }
            
            .navigationDestination(for: String.self){ string in
                if string == "signup"{
                    SignupView()
                }else if string == "Route"{
                    RouteView()
                        .navigationBarBackButtonHidden(true)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

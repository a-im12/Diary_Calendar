//
//  UserAuth.swift
//  DialyCalendar
//
//  Created by いーま on 2022/09/25.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class UserAuth{
    
    var uid:String = ""
    var email:String = ""

    let db = Firestore.firestore()
    let userInfo = UserInfo()
    
    // ユーザの新規作成
    func createUser(email: String, pass: String) -> Bool{
        var result:Bool = true
        Auth.auth().createUser(withEmail: email, password: pass) { (authResult, error)in
            guard authResult?.user != nil else{
                print("登録できません")
                result = false
                return
            }
            result = true
        }
        return result
    }
    // Firestoreへのアクセス
    func accessUserDB(uid:String, email:String){
        self.db.collection("users").document(uid).getDocument(){(document, error) in
            if let document = document {
                if document.exists{
                    print("already done")
                }else{
                    // 新規ユーザの場合はドキュメントの作成
                    self.userInfo.createNewUserDocument(uid: uid, email:email)
                }
            }
        }
    }
    
    // userIdの取得
    func getUserId() -> String{
        return self.uid
    }
    
    // emailの取得
    func getUserEmail() -> String{
        return self.email
    }
}

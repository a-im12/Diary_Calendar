//
//  UserInfo.swift
//  DialyCalendar
//
//  Created by いーま on 2022/09/25.
//

import Foundation
import FirebaseFirestore

class UserInfo{
    
    let db = Firestore.firestore()
    
    // Firestoreに登録されているユーザ情報の表示
    func getUserInfo(uid:String){
        self.db.collection("users").document(uid).getDocument{(document, error) in
            
            if let document = document{
                let dataDescription = document.data().map(String.init(describing: )) ?? "nil"
                print("Document data: \(dataDescription)")
            }
        }
    }
    
    // 入力欄の判定
    func checkEntry(email:String, pass:String) -> String{
        if email == ""{
            return "メールアドレスを入力してください。"
        }else if pass == ""{
            return "パスワードを入力してください"
        }else{
            return ""
        }
    }
    
    // 新規ログインユーザのドキュメント作成
    func createNewUserDocument(uid:String, email:String){
        self.db.collection("users").document(uid).setData([
            "uid" : uid,
            "email" : email,
            "display_name" : "anonymous",
            "create_date" : FirebaseFirestore.Timestamp()
        ]){error in
            if let error = error{
                print("Oh no!! this program has error!:\(error)")
            }else{
                print("success!")
            }
        }
    }
}

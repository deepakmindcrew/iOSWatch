//
//  InsertWorkout.swift
//  Phlex Swim Beta WatchKit Extension
//
//  Created by Apple on 18/03/21.
//

import Foundation

class InsertWorkout_VM {
    
    var obj_view : DoneButton?
    
    func getallUserData(){

        obj_view?.finishedAPI()
        
//        let str_endPoint = "api/ScratchCardget"
//
//        let url = URL(string: "APPDELEGATE.Base_URL_API" + str_endPoint)! //change the url
//        var request = URLRequest(url: url)
//        let userid = UserDefaults.standard.string(forKey: "user_id") ?? ""
//        request.httpMethod = "POST"
//
//        let parameters: [String: Any] = ["uid": userid]
//
//        do {
//            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
//
//        } catch _ {
//        }
//        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.addValue("application/json", forHTTPHeaderField: "Accept")
//
//        let plainText = "Bearer \(UserDefaults.standard.value(forKey: "DecritpHeaderK") ?? "")"
//        request.setValue(plainText, forHTTPHeaderField: "authorization")
//
//        //create dataTask using the session object to send data to the server
//        let task = URLSession.shared.dataTask(with: request as URLRequest, completionHandler: { [self] data, response, error in
//
//            if error == nil{
//                if let data = data{
////                    do{
////                        let userResponse = try JSONDecoder().decode(ScratchCard_Model.self, from: data)
////
////                        if userResponse.status == "true"{
////
////                        }
////
////                    }catch let err{
//////                        self.VC?.showAlert(str_msg: "Oops! something went wrong")
////
////                        print(err.localizedDescription)
////                    }
//                }
//            }else{
////                self.VC?.showAlert(str_msg: "Oops! something went wrong")
//            }
//        })
//        task.resume()
    }
}

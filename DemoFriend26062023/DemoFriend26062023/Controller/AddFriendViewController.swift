//
//  AddFriendViewController.swift
//  DemoFriend26062023
//
//  Created by Nguyễn Mạnh Linh on 29/06/2023.
//

import UIKit

class AddFriendViewController: UIViewController {
    
    @IBOutlet weak var txtPhoneNumber: UITextField!
    @IBOutlet weak var txtNickname: UITextField!
    @IBOutlet weak var txtFullName: UITextField!
    
    var person = FriendsResponseModel(fullName: "", nickName: "", avatar: "",phoneNumber: "", id: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.txtFullName.text = person.fullName
        self.txtNickname.text = person.nickName
        self.txtPhoneNumber.text = person.phoneNumber
    }

    @IBAction func btnSaveNewFriend(_ sender: Any) {
        let newFriend = FriendsResponseModel(fullName: "\(txtFullName.text ?? "")",
                                             nickName: "\(txtNickname.text ?? "")",
                                             avatar: "",
                                             phoneNumber: "\(txtPhoneNumber.text ?? "")",
                                             id: "")
        
        if person.id.isEmpty{
            APIHandler.init().addFriend(_friend: newFriend) { success in
                if success {
                    print("Thêm bạn thành công")
                    self.navigationController?.popViewController(animated: true)
                } else {
                    print("Lỗi khi thêm bạn")
                }
            }
        }else{
            APIHandler.init().updateFriend(id: person.id, _friend: newFriend) { success in
                if success {
                    print("Sửa bạn thành công")
                    self.navigationController?.popViewController(animated: true)
                } else {
                    print("Lỗi khi sửa bạn")
                }
            }
        }
    }
}


//
//  FriendsViewController.swift
//  DemoFriend26062023
//
//  Created by Nguyễn Mạnh Linh on 26/06/2023.
//

import UIKit
import Kingfisher

class FriendsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    @IBOutlet weak var tblFriends: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var friendData: [FriendsResponseModel] = []
    var filteredData: [FriendsResponseModel]!
    var isSearched: Bool = false
    var currentData: FriendsResponseModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblFriends.dataSource = self
        tblFriends.delegate = self
        tblFriends.register(UINib(nibName: "FriendsTableViewCell", bundle: nil), forCellReuseIdentifier: "FriendsCellIdentifier")
        callAPIFriends()
        filteredData = friendData
    }
    
    override func viewWillAppear(_ animated: Bool) {
        cellAPIGetFriends()
    }
    func cellAPIGetFriends() {
        APIHandler.init().getFriends { friendsResponseData in
            self.friendData = friendsResponseData
            self.filteredData = friendsResponseData
            self.tblFriends.reloadData()
        }
    }
    
    func callAPIFriends(){
        APIHandler.init().getFriends{friendsResponseModel in
            self.friendData = friendsResponseModel
            self.tblFriends.reloadData()
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(isSearched){
            return filteredData.count
        }else{
            return friendData.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblFriends.dequeueReusableCell(withIdentifier: "FriendsCellIdentifier") as! FriendsTableViewCell
        
        if(isSearched){
            currentData = filteredData[indexPath.row]
        }else{
            currentData = friendData[indexPath.row]
        }
        
        cell.lblNameAndNick.text = currentData.fullName + " - " + currentData.nickName
        cell.lblPhoneNumber.text = currentData.phoneNumber
        
        let url = URL(string: currentData.avatar)
        cell.imgAvtFriends.kf.setImage(with: url)
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = storyboard?.instantiateViewController(withIdentifier: "AddFriendViewController") as! AddFriendViewController
        let person = FriendsResponseModel(fullName: "\(friendData[indexPath.row].fullName)",
                                          nickName: "\(friendData[indexPath.row].nickName)",
                                          avatar: "\(friendData[indexPath.row].avatar)",
                                          phoneNumber: "\(friendData[indexPath.row].phoneNumber)",
                                          id: "\(friendData[indexPath.row].id)")
        detailVC.person = person
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let friendID = filteredData[indexPath.row].id
            APIHandler.init().deleteFriend(id: friendID) { success in
                if success {
                    print("Xoá bạn thành công")
                    self.friendData.remove(at: indexPath.row)
                    self.tblFriends.reloadData()
                    self.navigationController?.popViewController(animated: true)
                } else {
                    print("Lỗi khi xoá bạn")
                }
            }
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredData = []
        if searchText != ""{
            isSearched = true
            for check in friendData {
                if check.fullName.uppercased().contains(searchText.uppercased()){
                    filteredData.append(check)
                }
            }
        }else{
            filteredData = friendData
            isSearched = false
        }
        tblFriends.reloadData()
    }
}


//
//  HomeViewController.swift
//  LoginWithFirebaseApp
//
//  Created by Shin on 2021/01/18.
//

import Foundation
import UIKit
import Firebase

class HomeViewController: UIViewController {
    
    var user: User? {
        didSet {
            print("user?.name: ",user?.name)
        }
    }
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var logoutButton: UIButton!
    
    
    @IBAction func tappedLogoutButton(_ sender: Any) {
       handleLogout()
    }
    
    private func handleLogout() {
        do {
            try Auth.auth().signOut()
            dismiss(animated: true, completion: nil)
            //          presentToMainViewController()
        }  catch (let err) {
            print("ログアウトに失敗しました。: \(err)")
            
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
       
        logoutButton.layer.cornerRadius = 10

        if let user = user {
            
        nameLabel.text = user.name + "さんようこそ"
        emailLabel.text = user.email
            
        let dateString = dateFormatterForCreatedAt(date: user.createdAt.dateValue())
        dateLabel.text = "作成日: " + dateString
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        confirmLoggedInUser()
    }
    
    private func confirmLoggedInUser() {
        if Auth.auth().currentUser?.uid == nil || user == nil {
           presentToMainViewController()
         
       //     let navController = UINavigationController(rootViewController: viewController)
       //     navController.modalPresentationStyle = .fullScreen
            
        
        }
    }
    
    
      private func presentToMainViewController() {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyBoard.instantiateViewController(identifier: "ViewController") as! ViewController
    //    viewController.modalPresentationStyle = .fullScreen
        let navController = UINavigationController(rootViewController: viewController)
       navController.modalPresentationStyle = .fullScreen
        self.present(navController, animated: true, completion: nil)
        
        
    }
    

    
    private func dateFormatterForCreatedAt(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        formatter.locale = Locale(identifier: "ja_Jp")
        return formatter.string(from: date)
     
    }
        
    }




//
//  FirstViewController.swift
//  Feel Better
//
//  Created by Apollo Zhu on 10/12/19.
//  Copyright © 2019 Feel Better. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
import FirebaseFirestore


let db = Firestore.firestore()
let diariesRef = db.collection("diaries")
let docRef = db.collection("diaries").document("today")
let data = Data()
let storage = Storage.storage()
let storageRef = storage.reference()

class FirstViewController: UIViewController {
    
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // create record into Firebases
        ref = Database.database().reference()
        ref.child("name").childByAutoId().setValue("visual")
        ref.child("name").childByAutoId().setValue("phanith")
        
    }
    
    func setDocument(){
    // Add a new document in collection "diaries"
    db.collection("diaries").document("today").setData([
        "title": "Journal",
        "content": "content",
        "sentiments":"happy",
        "saveDate": "10/12/19"
    ]) { err in
        if let err = err {
            print("Error writing document: \(err)")
        } else {
            print("Document successfully written!")
        }
      }
    }
    
    func readData(){
        // read the data
        diariesRef.document("diaries").setData([
        "title": "Jorunal",
        "content": "content",
        "sentiments":"happy",
        "saveDate": "10/12/19"
    ])}
    
    func getDoc(){
        //get the document from designated collection
        docRef.getDocument {(document, error) in
            if let document = document, document.exists {
                let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                print("Document data: \(dataDescription)")
            } else {
                print("Document does not exist")
            }
        }
    }
    
    func errorHandler(ErrorReporter : String) -> Void {
        let _ = "upload unsuccessful"
    }
    func uploadFilesFromMemory(ErrorReporter : (String) -> Void){
        
        // Create a reference to the file you want to upload
        let picsRef = storageRef.child("images/user.jpg")

        // Upload the file to the path "images/rivers.jpg"
       _ = picsRef.putData(data, metadata: nil) { (metadata, error) in
          guard let metadata = metadata else {
            // Uh-oh, an error occurred!
            return
          }
          // Metadata contains file metadata such as size, content-type.
          _ = metadata.size
        
          // You can also access to download URL after upload.
          picsRef.downloadURL { (url, error) in
            guard let downloadURL = url else {
              // Uh-oh, an error occurred!
              return
            }
          }
        }
    }
    
    
    func uploadFilesFromLocal (ErrorReporter : (String) -> Void ) -> Void {
        // File located on disk
        let localFile = URL(string: "path/to/file")!

        // Create a reference to the file you want to upload
        let picsRef = storageRef.child("images/user.jpg")

        // Upload the file to the path "images/rivers.jpg"
        _ = picsRef.putFile(from: localFile, metadata: nil) { metadata, error in
          guard let metadata = metadata else {
            // Uh-oh, an error occurred!
            return
          }
          // Metadata contains file metadata such as size, content-type.
          _ = metadata.size
          // You can also access to download URL after upload.
            picsRef.downloadURL { (url, error) in
            guard let downloadURL = url else {
              // Uh-oh, an error occurred!
                
              return
                              
            }
          }
        }
    }
    
}

extension Array {
    func toFirebaseDictionary() -> [Int: Element] {
        return Dictionary<Int, Element>(uniqueKeysWithValues: zip(indices, self))
    }
}


//
//  ChatViewController.swift
//  Schooler
//
//  Created by Huang Zhou on 2017-04-21.
//  Copyright © 2017 Huang Zhou. All rights reserved.
//

import UIKit
import JSQMessagesViewController
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase
import MobileCoreServices
import AVKit


class ChatViewController: JSQMessagesViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    var messages = [JSQMessage]()

    var outgoingBubbleImageView: JSQMessagesBubbleImage!
    var incomingBubbleImageView: JSQMessagesBubbleImage!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Messages"
        
        let factory = JSQMessagesBubbleImageFactory()
        
        incomingBubbleImageView = factory?.incomingMessagesBubbleImage(with: UIColor.jsq_messageBubbleLightGray())
        outgoingBubbleImageView = factory?.outgoingMessagesBubbleImage(with: UIColor.jsq_messageBubbleBlue())
        
        collectionView.collectionViewLayout.incomingAvatarViewSize = CGSize.zero
        collectionView.collectionViewLayout.outgoingAvatarViewSize = CGSize.zero
        
        addMessage("boom", displayName: "User2", text: "Hey, how are you?")
        addMessage("boom", displayName: "User2", text: "Huang")
        addMessage(senderId, displayName: FIRAuth.auth()!.currentUser!.displayName!, text: "Hey, I am good and you?")
        
        finishReceivingMessage()
        self.edgesForExtendedLayout = []
        
        
    }
    
    
    func addMessage(_ id: String, displayName: String, text: String){
        
        let message = JSQMessage(senderId:id, displayName: displayName, text: text)
        messages.append(message!)
 
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = super.collectionView(collectionView, cellForItemAt: indexPath) as! JSQMessagesCollectionViewCell
        
        let message = messages[indexPath.item]
        
        if message.senderId == senderId {
            cell.textView.textColor = UIColor.white
        }else {
            cell.textView.textColor = UIColor.black
            
        }
        
        return cell
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageDataForItemAt indexPath: IndexPath!) -> JSQMessageData! {
        return messages[indexPath.item]
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    
    
    override func didPressSend(_ button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: Date!) {
        
        
    }
    
    override func didPressAccessoryButton(_ sender: UIButton!) {
        
        let alertController = UIAlertController(title: "Medias", message: "Choose your media", preferredStyle: UIAlertControllerStyle.actionSheet)
        
        
        let imageAction = UIAlertAction(title: "Image", style: UIAlertActionStyle.default) { (action) in
            self.getMedia(kUTTypeImage)
            
        }
        
        let videoAction = UIAlertAction(title: "Video", style: UIAlertActionStyle.default) { (action) in
            self.getMedia(kUTTypeMovie)
            
            
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil)
        
        alertController.addAction(imageAction)
        alertController.addAction(videoAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
        
        
    }
    
    
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAt indexPath: IndexPath!) -> JSQMessageBubbleImageDataSource! {
        
        let message = messages[indexPath.item]
        if message.senderId == senderId {
            return outgoingBubbleImageView
        }else {
            return incomingBubbleImageView
        }
        
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, avatarImageDataForItemAt indexPath: IndexPath!) -> JSQMessageAvatarImageDataSource! {
        return nil
    }
    
    fileprivate func getMedia(_ mediaType: CFString){
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.isEditing = true
        
        if mediaType == kUTTypeImage {
            
            imagePicker.mediaTypes = [mediaType as String]
            
        } else if mediaType == kUTTypeMovie {
            
            imagePicker.mediaTypes = [mediaType as String]
            
        }
        
        present(imagePicker, animated: true, completion: nil)
        
        
    }
}

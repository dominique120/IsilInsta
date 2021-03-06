//
//  MainPostCell.swift
//  InputConConstraints
//
//  Created by Dominique Verellen on 12/2/20.
//  Copyright © 2020 Kenyi Rodriguez. All rights reserved.
//

import UIKit

protocol MainPostDelegate {
    func targetPost(_ cell: StreamCell, selectedPost objPlace: PostBE)
}

class StreamCell: UITableViewCell {
    
    @IBOutlet weak var personName: UIButton!
    @IBOutlet weak var imgPost: UIImageView!
    @IBOutlet weak var likePost: UIButton!
    @IBOutlet weak var commentOnPost: UIButton!
    @IBOutlet weak var postContent: UILabel!
    
    weak var parentViewController : MainPost?
    
    var delegate: MainPostDelegate?
    
    @IBAction func viewComments(_ sender: Any) {
        g_activePostId = objPost.postId
        g_activePersonId = objPost.personId
        self.delegate?.targetPost(self, selectedPost: self.objPost)
    }
    
    @IBAction func viewProfile(_ sender: Any) {
        g_activePostId = objPost.postId
        g_activePersonId = objPost.personId
        self.delegate?.targetPost(self, selectedPost: self.objPost)
    }
    
    var objPost: PostBE! {
        didSet {
            self.updateData()
        }
    }
    
    private func updateData() {
        self.postContent.text = self.objPost.mainContent
        
        self.imgPost.downloadImageInUrlString(Constants.image_fs + self.objPost.pictureUrl) { (image, urlString) in
            self.imgPost.image = image
        }
        self.personName.setTitle(self.objPost.posterName, for: .normal)
    }
    
    override func draw(_ rect: CGRect) {
        self.imgPost.layer.cornerRadius = 20
    }
    
    @IBAction func likePost(_ sender: Any) {
        LikeWS.newLike(postId: objPost.postId, personId: PersonBE.shared!.personId, success: {            
            Util.showMessage(controller: self.parentViewController!, message: "Like!", seconds: 1.5)            
        }, error: {
            (errorMessage) in
            print(errorMessage)
        })
    }
}


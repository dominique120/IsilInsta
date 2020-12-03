//
//  CommentBL.swift
//  InputConConstraints
//
//  Created by Dominique Verellen on 12/2/20.
//  Copyright © 2020 Kenyi Rodriguez. All rights reserved.
//

import Foundation


class CommentBL {
    
    class func getCommentsByPost(_ success: @escaping Comments, postId: String) {
                
        CommentWS.getCommentsByPost({(arrayComments) in
            success(arrayComments)
        }, postId: postId)
    }
}
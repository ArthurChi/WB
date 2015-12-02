//
//  UITextView+Extention.swift
//  WeiBo
//
//  Created by jie Chi on 12/2/15.
//  Copyright © 2015 Cjfire. All rights reserved.
//

import UIKit

extension UITextView {

    func inputEmotion(emotionItem: EmotionItem) {
        
        if emotionItem.isEmpty {
            return
        }
        
        if emotionItem.isRemove {
            deleteBackward()
            return
        }
        
        if let emoji = emotionItem.emoji {
            replaceRange(selectedTextRange!, withText: emoji)
            return
        }
        
        let t = NSTextAttachment(data: .None, ofType: .None)
        t.image = UIImage(contentsOfFile: emotionItem.imgPath!)
        
        let lineHeight = font!.lineHeight
        print(lineHeight)
        t.bounds = CGRect(x: 0, y: -10, width: lineHeight, height: lineHeight)
        
        let imageText = NSMutableAttributedString(attributedString: NSAttributedString(attachment: t))
        
        imageText.addAttribute(NSFontAttributeName, value: font!, range: NSRange(location: 0, length: 1))
        
        let strM = NSMutableAttributedString(attributedString: attributedText)
        
        strM.replaceCharactersInRange(selectedRange, withAttributedString: imageText)
        
        let range = selectedRange
        attributedText = strM
        selectedRange = NSRange(location: range.location + 1, length: 0)
        
        delegate?.textViewDidChange?(self)

    }
}

/// 表情附件
class EmoticonAttachment: NSTextAttachment {
    
    var emoticon: EmotionItem
    
    func imageText(font: UIFont) -> NSAttributedString {
        
        image = UIImage(contentsOfFile: emoticon.imgPath!)
        
        let lineHeight = font.lineHeight
        
        bounds = CGRect(x: 0, y: -4, width: lineHeight, height: lineHeight)
        
        let imageText = NSMutableAttributedString(attributedString: NSAttributedString(attachment: self))
        
        imageText.addAttribute(NSFontAttributeName, value: font, range: NSRange(location: 0, length: 1))
        
        return imageText
    }
    
    init(emoticon: EmotionItem) {
        self.emoticon = emoticon
        
        super.init(data: nil, ofType: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
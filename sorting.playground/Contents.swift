//: Playground - noun: a place where people can play

import UIKit

//func valueTest(v: inout Int) {
////    v = v * 2
//    var vv = v
//    vv = v * 2
//    v = vv
//}
//
//var xval: Int = 2
//
//valueTest(v: &xval)
//
//xval

//print("hell")
//debugPrint(xval)


//let appleName = "TV"
//appleName.characters.count
//
//let punc = "Hello.there.you.beast"
//let thepunc = ".,!?:;'`\\<>/(){}[]"
////let fs = CharacterSet(charactersIn: ".,!?:;'`\\<>/(){}[]")
//
//let np = punc.characters.map({ (char) -> Character in
//    if char == "." {
//        return "*"
//    } else {
//        return char
//    }
//})
//
//np
//
//np.map {
//    String($0)
//}.joined(separator: "")

//{
//    if ($0) == "." {
//        return " "
//    }
//}

// FIND THE HASHTAG RANGES FOR THE ATTRIBUTED STRING

//let strText = "This is a really great thing #BigThing"
//let nsText = strText as NSString
//let attrStr = NSMutableAttributedString(string: strText)
//let textRange = NSMakeRange(0, nsText.length)
//
//
//attrStr.addAttribute(NSForegroundColorAttributeName, value: UIColor.red, range: textRange)
//
//nsText.enumerateSubstrings(in: textRange, options: .byWords) { (substring, substringRange, _, _) in
//    if substring?.characters.first == "#" {
//        attrStr.addAttribute(NSLinkAttributeName, value: "hashtag:/", range: substringRange)
//        attrStr.addAttribute(NSForegroundColorAttributeName, value: UIColor.init(red: 29/255, green: 174/255, blue: 212/255, alpha: 1.0), range: substringRange)
//        attrStr.addAttribute(NSUnderlineStyleAttributeName, value: NSUnderlineStyle.styleSingle.rawValue, range: substringRange)
//        attrStr.addAttribute(NSUnderlineColorAttributeName, value: UIColor(red: 29.0/255.0, green: 174.0/255.0, blue: 212.0/255.0, alpha: 1.0), range: substringRange)
//        print("boom")
//    }
//}
//
//print(attrStr)

//let strArr = strText.components(separatedBy: " ")
//var hashArr = [String]()
//
//for sub in strArr {
//    if sub.characters.first == "#" {
//        hashArr.append(sub)
//    }
//}
//
//for htag in hashArr {
//    if let range = strText.range(of: htag) {
//        let lo = strText.index(range.lowerBound, offsetBy: 0)
//        let hi = strText.index(range.upperBound, offsetBy: 0)
//        let subRange = lo ..< hi
//        print(strText[subRange]) // "DE"
//    }
//}

let hashTags = ["#one", "#two", "#three"] as NSArray

let filterString = "#o"
let predicate = NSPredicate(format: "SELF BEGINSWITH[c] %@", argumentArray: [filterString])
let filteredTags = hashTags.filtered(using: predicate)

let tags = NSMutableArray(arrayLiteral: "#one", "#two")
var suggTags = [Any]()

let boo = tags.map {
    suggTags.append($0)
}

boo
suggTags



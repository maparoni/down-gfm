//
//  Strikethrough.swift
//  
//
//  Created by Adrian Schönig on 8/3/2022.
//

import Foundation
import libcmark

public class Strikethrough: BaseNode {}

// MARK: - Debug

extension Strikethrough: CustomDebugStringConvertible {

    public var debugDescription: String {
        return "Strikethrough"
    }

}

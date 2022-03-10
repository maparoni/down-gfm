//
//  MarkupVisitor+Children.swift
//  
//
//  Created by Adrian Schönig on 9/3/2022.
//

import Foundation
import Markdown

extension MarkupVisitor {

    public mutating func visitChildren(_ children: MarkupChildren) -> [Result] {
        return children.compactMap { child in
            visit(child)
        }
    }

}

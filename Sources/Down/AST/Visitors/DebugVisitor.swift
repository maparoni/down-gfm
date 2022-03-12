//
//  DebugVisitor.swift
//  Down
//
//  Created by John Nguyen on 09.04.19.
//

import Foundation
import Markdown

/// This visitor will generate the debug description of an entire abstract syntax tree,
/// indicating relationships between nodes with indentation.

public struct DebugVisitor: MarkupVisitor {

    // MARK: - Properties

    private var depth = 0

    private var indent: String {
        return String(repeating: "    ", count: depth)
    }

    // MARK: - Life cycle

    public init() {}

    // MARK: - Helpers

    private func report(_ node: Markup) -> String {
        return "\(indent)\(node is Document ? "" : "↳ ")\(String(reflecting: node))\n"
    }

    private mutating func reportWithChildren(_ node: Markup) -> String {
        let thisNode = report(node)
        guard node.childCount > 0 else { return thisNode }
        
        depth += 1
        let children = visitChildren(node.children).joined()
        depth -= 1
        return "\(thisNode)\(children)"
    }

    // MARK: - Visitor

    public typealias Result = String
    
    public mutating func defaultVisit(_ markup: Markup) -> String {
        return reportWithChildren(markup)
    }

}

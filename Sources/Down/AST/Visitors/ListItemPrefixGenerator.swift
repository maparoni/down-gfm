//
//  ListItemPrefixGenerator.swift
//  Down
//
//  Created by John Nguyen on 23.06.19.
//  Copyright © 2016-2019 Down. All rights reserved.
//

import Foundation
import Markdown

/// A ListItemPrefixGenerator is an object used to generate list item prefix.
public protocol ListItemPrefixGenerator {
    init(listType: ListType, numberOfItems: Int, nestDepth: Int)
    func next() -> String?
}

public extension ListItemPrefixGenerator {
    init(list: List) {
        switch list {
        case .ordered(let ordered):
            #warning("TODO: Fix start when this is merged: https://github.com/apple/swift-markdown/pull/22")
            self.init(listType: .ordered(start: 1), numberOfItems: ordered.childCount, nestDepth: 0 /* list.nestDepth */)
        case .unordered(let unordered):
            self.init(listType: .bullet, numberOfItems: unordered.childCount, nestDepth: 0 /* list.nestDepth */)
        }
    }
}

public enum List {
    case ordered(OrderedList)
    case unordered(UnorderedList)
}

public enum ListType {
    case bullet
    case ordered(start: Int)
}

/// Default implementation of `ListItemPrefixGenerator`.
/// Generating the following symbol based on `List.ListType`:
/// - List.ListType is bullet => "•"
/// - List.ListType is ordered => "X." (where is the item number)
public class StaticListItemPrefixGenerator: ListItemPrefixGenerator {

    // MARK: - Properties

    private var prefixes: IndexingIterator<[String]>

    // MARK: - Life cycle

    required public init(listType: ListType, numberOfItems: Int, nestDepth: Int) {
            switch listType {
            case .bullet:
                prefixes = [String](repeating: "•", count: numberOfItems)
                    .makeIterator()

            case .ordered(let start):
                prefixes = (start..<(start + numberOfItems))
                    .map { "\($0)." }
                    .makeIterator()
            }
        }

    // MARK: - Methods

    public func next() -> String? {
        prefixes.next()
    }

}

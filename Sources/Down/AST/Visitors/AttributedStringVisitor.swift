//
//  AttributedStringVisitor.swift
//  Down
//
//  Created by John Nguyen on 09.04.19.
//

#if !os(Linux)

import Foundation
import Markdown

/// This class is used to generated an `NSMutableAttributedString` from the abstract syntax
/// tree produced by a markdown string. It traverses the tree to construct substrings
/// represented at each node and uses an instance of `Styler` to apply the visual attributes.
/// These substrings are joined together to produce the final result.

public typealias ListPrefixGeneratorBuilder = (List) -> ListItemPrefixGenerator

public struct AttributedStringVisitor {

    // MARK: - Properties

    private let styler: Styler
    private let options: DownOptions
    private let listPrefixGeneratorBuilder: ListPrefixGeneratorBuilder
    private var listPrefixGenerators = [ListItemPrefixGenerator]()

    /// Creates a new instance with the given styler and options.
    ///
    /// - parameters:
    ///     - styler: used to style the markdown elements.
    ///     - options: may be used to modify rendering.
    ///     - listPrefixGeneratorBuilder: may be used to modify list prefixes.

    public init(
        styler: Styler,
        options: DownOptions = .default,
        listPrefixGeneratorBuilder: @escaping ListPrefixGeneratorBuilder = { StaticListItemPrefixGenerator(list: $0) }
    ) {
        self.styler = styler
        self.options = options
        self.listPrefixGeneratorBuilder = listPrefixGeneratorBuilder
    }

}

extension AttributedStringVisitor: MarkupVisitor {

    public typealias Result = NSMutableAttributedString

    public mutating func defaultVisit(_ markup: Markup) -> Result {
        return .empty
    }
    
    public mutating func visitDocument(_ document: Document) -> NSMutableAttributedString {
        let result = visitChildren(document.children).joined
        styler.style(document: result)
        return result
    }

    public mutating func visitBlockQuote(_ node: BlockQuote) -> NSMutableAttributedString {
        let result = visitChildren(node.children).joined
        if node.hasSuccessor { result.append(.paragraphSeparator) }
        styler.style(blockQuote: result, nestDepth: /*node.nestDepth*/ 0)
        return result
    }

    public mutating func visitOrderedList(_ node: OrderedList) -> NSMutableAttributedString {
        listPrefixGenerators.append(listPrefixGeneratorBuilder(.ordered(node)))
        defer { listPrefixGenerators.removeLast() }

        let items = visitChildren(node.children)

        let result = items.joined
        if node.hasSuccessor { result.append(.paragraphSeparator) }
        styler.style(list: result, nestDepth: /*node.nestDepth*/ 0)
        return result
    }
    
    public mutating func visitUnorderedList(_ node: UnorderedList) -> NSMutableAttributedString {
        listPrefixGenerators.append(listPrefixGeneratorBuilder(.unordered(node)))
        defer { listPrefixGenerators.removeLast() }

        let items = visitChildren(node.children)

        let result = items.joined
        if node.hasSuccessor { result.append(.paragraphSeparator) }
        styler.style(list: result, nestDepth: /*node.nestDepth*/ 0)
        return result
    }

    public mutating func visitListItem(_ node: ListItem) -> NSMutableAttributedString {
        let result = visitChildren(node.children).joined

        let prefix = listPrefixGenerators.last?.next() ?? "•"
        let attributedPrefix = "\(prefix)\t".attributed
        styler.style(listItemPrefix: attributedPrefix)
        result.insert(attributedPrefix, at: 0)

        if node.hasSuccessor { result.append(.paragraphSeparator) }
        styler.style(item: result, prefixLength: (prefix as NSString).length)
        return result
    }

    public func visitCodeBlock(_ node: CodeBlock) -> NSMutableAttributedString {
        guard !node.code.isEmpty else { return .empty }
        let result = node.code.replacingNewlinesWithLineSeparators().attributed
        if node.hasSuccessor { result.append(.paragraphSeparator) }
        styler.style(codeBlock: result, fenceInfo: node.language)
        return result
    }

    public func visitHTMLBlock(_ node: HTMLBlock) -> NSMutableAttributedString {
        guard !node.rawHTML.isEmpty else { return .empty }
        let result = node.rawHTML.replacingNewlinesWithLineSeparators().attributed
        if node.hasSuccessor { result.append(.paragraphSeparator) }
        styler.style(htmlBlock: result)
        return result
    }

    public func visitCustomBlock(_ node: CustomBlock) -> NSMutableAttributedString {
        return .empty
//        guard let result = node.literal?.attributed else { return .empty }
//        styler.style(customBlock: result)
//        return result
    }

    public mutating func visitParagraph(_ node: Paragraph) -> NSMutableAttributedString {
        let result = visitChildren(node.children).joined
        if node.hasSuccessor { result.append(.paragraphSeparator) }
        styler.style(paragraph: result)
        return result
    }

    public mutating func visitHeading(_ node: Heading) -> NSMutableAttributedString {
        let result = visitChildren(node.children).joined
        if node.hasSuccessor { result.append(.paragraphSeparator) }
        styler.style(heading: result, level: node.level)
        return result
    }

    public func visitThematicBreak(_ node: ThematicBreak) -> NSMutableAttributedString {
        let result = "\(String.zeroWidthSpace)\n".attributed
        styler.style(thematicBreak: result)
        return result
    }

    public func visitText(_ node: Text) -> NSMutableAttributedString {
        guard !node.string.isEmpty else { return .empty }
        let result = node.string.attributed
        styler.style(text: result)
        return result
    }

    public func visitSoftBreak(_ node: SoftBreak) -> NSMutableAttributedString {
//        let result = (options.contains(.hardBreaks) ? String.lineSeparator : " ").attributed
        let result = " ".attributed
        styler.style(softBreak: result)
        return result
    }

    public func visitLineBreak(_ node: LineBreak) -> NSMutableAttributedString {
        let result = String.lineSeparator.attributed
        styler.style(lineBreak: result)
        return result
    }

    public func visitInlineCode(_ node: InlineCode) -> NSMutableAttributedString {
        guard !node.code.isEmpty else { return .empty }
        let result = node.code.attributed
        styler.style(code: result)
        return result
    }

    public func visitInlineHTML(_ node: InlineHTML) -> NSMutableAttributedString {
        guard !node.rawHTML.isEmpty else { return .empty }
        let result = node.rawHTML.attributed
        styler.style(htmlInline: result)
        return result
    }

    public func visitCustomInline(_ node: CustomInline) -> NSMutableAttributedString {
        guard !node.text.isEmpty else { return .empty }
        let result = node.text.attributed
        styler.style(customInline: result)
        return result
    }

    public mutating func visitEmphasis(_ node: Emphasis) -> NSMutableAttributedString {
        let result = visitChildren(node.children).joined
        styler.style(emphasis: result)
        return result
    }

    public mutating func visitStrikethrough(_ node: Strikethrough) -> NSMutableAttributedString {
        let result = visitChildren(node.children).joined
        styler.style(strikethrough: result)
        return result
    }

    public mutating func visitStrong(_ node: Strong) -> NSMutableAttributedString {
        let result = visitChildren(node.children).joined
        styler.style(strong: result)
        return result
    }

    public mutating func visitLink(_ node: Link) -> NSMutableAttributedString {
        let result = visitChildren(node.children).joined
        styler.style(link: result, title: node.plainText, url: node.destination)
        return result
    }

    public mutating func visitImage(_ node: Image) -> NSMutableAttributedString {
        let result = visitChildren(node.children).joined
        styler.style(image: result, title: node.title, url: nil)
        return result
    }
}

// MARK: - Helper extensions

extension Markup {
    var hasSuccessor: Bool {
        guard let parent = parent else { return false }
        return indexInParent < parent.childCount - 1
    }
}

private extension Sequence where Iterator.Element == NSMutableAttributedString {

    var joined: NSMutableAttributedString {
        return reduce(into: NSMutableAttributedString()) { $0.append($1) }
    }

}

private extension NSMutableAttributedString {

    static var empty: NSMutableAttributedString {
        return "".attributed
    }

}

private extension NSAttributedString {

    static var paragraphSeparator: NSAttributedString {
        return String.paragraphSeparator.attributed
    }

}

private extension String {

    var attributed: NSMutableAttributedString {
        return NSMutableAttributedString(string: self)
    }

    // This codepoint marks the end of a paragraph and the start of the next.

    static var paragraphSeparator: String {
        return "\u{2029}"
    }

    // This code point allows line breaking, without starting a new paragraph.

    static var lineSeparator: String {
        return "\u{2028}"
    }

    static var zeroWidthSpace: String {
        return "\u{200B}"
    }

    func replacingNewlinesWithLineSeparators() -> String {
        let trimmed = trimmingCharacters(in: .newlines)
        let lines = trimmed.components(separatedBy: .newlines)
        return lines.joined(separator: .lineSeparator)
    }

}

#endif // !os(Linux)

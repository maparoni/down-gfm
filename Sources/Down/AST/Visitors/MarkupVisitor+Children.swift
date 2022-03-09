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
            switch child {
            case let child as Document:       return visitDocument(child)
            case let child as BlockQuote:     return visitBlockQuote(child)
            case let child as OrderedList:    return visitOrderedList(child)
            case let child as UnorderedList:  return visitUnorderedList(child)
            case let child as ListItem:       return visitListItem(child)
            case let child as CodeBlock:      return visitCodeBlock(child)
            case let child as HTMLBlock:      return visitHTMLBlock(child)
            case let child as CustomBlock:    return visitCustomBlock(child)
            case let child as Paragraph:      return visitParagraph(child)
            case let child as Heading:        return visitHeading(child)
            case let child as ThematicBreak:  return visitThematicBreak(child)
            case let child as Text:           return visitText(child)
            case let child as SoftBreak:      return visitSoftBreak(child)
            case let child as LineBreak:      return visitLineBreak(child)
            case let child as InlineCode:     return visitInlineCode(child)
            case let child as InlineHTML:     return visitInlineHTML(child)
            case let child as CustomInline:   return visitCustomInline(child)
            case let child as Emphasis:       return visitEmphasis(child)
            case let child as Strong:         return visitStrong(child)
            case let child as Link:           return visitLink(child)
            case let child as Image:          return visitImage(child)
            case let child as Strikethrough:  return visitStrikethrough(child)
            default:
                assertionFailure("Unexpected child")
                return nil
            }
        }
    }

}

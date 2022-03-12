//
//  DownASTRenderable.swift
//  Down
//
//  Created by Rob Phillips on 5/31/16.
//  Copyright © 2016-2019 Down. All rights reserved.
//

import Foundation

import cmark_gfm
import cmark_gfm_extensions
import Markdown

public protocol DownASTRenderable: DownRenderable {

    func toDocument(_ options: DownOptions) -> Document

}

extension DownASTRenderable {

    /// Generates an abstract syntax tree from the `markdownString` property.
    ///
    /// - Parametera:
    ///     - options: `DownOptions` to modify parsing or rendering, defaulting to `.default`.
    ///
    /// - Returns:
    ///     An abstract syntax tree representation of the Markdown input.
    ///
    /// - Throws:
    /// `MarkdownToASTError` if conversion fails.

    func toAST(_ options: DownOptions = .default) throws -> UnsafeMutablePointer<cmark_node> {
        return try DownASTRenderer.stringToNode(markdownString, options: options)
    }

    /// Parses the `markdownString` property into an abstract syntax tree and returns the root `Document` node.
    ///
    /// - Parameters:
    ///     - options: `DownOptions` to modify parsing or rendering, defaulting to `.default`.
    ///
    /// - Returns:
    ///     The root Document node for the abstract syntax tree representation of the Markdown input.
    ///
    /// - Throws:
    ///     `MarkdownToASTError` if conversion fails.

    public func toDocument(_ options: DownOptions = .default) -> Document {
        return Document(parsing: markdownString)
    }

}

public struct DownASTRenderer {

    /// Generates an abstract syntax tree from the given CommonMark Markdown string.
    ///
    /// **Important:** It is the caller's responsibility to call `cmark_node_free(ast)` on the returned value.
    ///
    /// - Parameters:
    ///     - string: A string containing CommonMark Markdown.
    ///     - options: `DownOptions` to modify parsing or rendering, defaulting to `.default`.
    ///
    /// - Returns:
    ///     An abstract syntax tree representation of the Markdown input.
    ///
    /// - Throws:
    ///     `MarkdownToASTError` if conversion fails.
    static func stringToNode(_ string: String, options: DownOptions = .default) throws -> UnsafeMutablePointer<cmark_node> {
        
        // enable GFM extensions
        cmark_gfm_core_extensions_ensure_registered()
        let parser: UnsafeMutablePointer<cmark_parser> = cmark_parser_new(options.rawValue)
        defer {
            cmark_parser_free(parser)
        }
        
        var ext: UnsafeMutablePointer<cmark_syntax_extension>;
        
        ext = cmark_find_syntax_extension("tagfilter")
        cmark_parser_attach_syntax_extension(parser, ext)

        ext = cmark_find_syntax_extension("autolink")
        cmark_parser_attach_syntax_extension(parser, ext)
        
        ext = cmark_find_syntax_extension("strikethrough")
        cmark_parser_attach_syntax_extension(parser, ext)
        
        ext = cmark_find_syntax_extension("tasklist")
        cmark_parser_attach_syntax_extension(parser, ext)

        if options.contains(.enableTables) {
            // Opt-in as not supported by NSAttribtedString on iOS
            ext = cmark_find_syntax_extension("table")
            cmark_parser_attach_syntax_extension(parser, ext)
        }
        
        var tree: UnsafeMutablePointer<cmark_node>?
        
        string.withCString {
            let stringLength = Int(strlen($0))
            // tree = cmark_parse_document($0, stringLength, options.rawValue)
            cmark_parser_feed(parser, $0, stringLength)
            tree = cmark_parser_finish(parser)
        }
        
        guard let ast = tree else {
            throw DownErrors.markdownToASTError
        }
        
        return ast
    }
    
    public static func stringToAST(_ string: String, options: DownOptions = .default) -> Document {
        return Document(parsing: string)
    }

}

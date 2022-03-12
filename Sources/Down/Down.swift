//
//  Down.swift
//  Down
//
//  Created by Rob Phillips on 5/28/16.
//  Copyright © 2016-2019 Down. All rights reserved.
//

import Foundation

public struct Down: DownASTRenderable, DownHTMLRenderable, DownXMLRenderable,
                    DownLaTeXRenderable, DownGroffRenderable, DownCommonMarkRenderable {
    /// A string containing GitHub-Flavored Markdown
    public var markdownString: String

    /// Initializes the container with a GitHub-Flavored Markdown string which can then be
    /// rendered depending on protocol conformance.
    ///
    /// - Parameter markdownString: A string containing GitHub-Flavored Markdown
    public init(markdownString: String) {
        self.markdownString = markdownString
    }
}

#if !os(Linux)
extension Down: DownAttributedStringRenderable { }
#endif // !os(Linux)

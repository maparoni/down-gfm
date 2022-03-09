//
//  DownOptions.swift
//  Down
//
//  Created by Rob Phillips on 5/28/16.
//  Copyright © 2016-2019 Down. All rights reserved.
//

import Foundation
import Markdown

public struct DownOptions: OptionSet {

    // MARK: - Properties

    public let rawValue: Int32

    // MARK: - Life cycle

    public init(rawValue: Int32) { self.rawValue = rawValue }

    /// Default options.

    public static let `default` = DownOptions(rawValue: 0)

}

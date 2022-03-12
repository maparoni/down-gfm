//
//  GFMStyleTests.swift
//  DownTests
//
//  Created by John Nguyen on 05.08.19.
//  Copyright © 2016-2019 Down. All rights reserved.
//

#if os(iOS)

class GFMStyleTests: StylerTestSuite {

    /// # Important
    ///
    /// Snapshot tests must be run on the same simulator used to record the reference snapshots, otherwise
    /// the comparison may fail. These tests were recorded on the **iPhone 12** simulator.
    ///

    func testThat_Strikethrough_IsStyled() {
        // Given
        let markdown = """
        Etiam vel dui id purus ~~finibus auctor~~. Donec in semper ~~lectus~~.
        """

        // Then
        assertStyle(for: markdown, width: .wide)
    }

  func testThat_TaskList_IsStyled() {
      // Given
      let markdown = """
      - [ ] Etiam vel dui id purus finibus auctor.
      - [x] Donec in semper lectus.
      """

      // Then
      assertStyle(for: markdown, width: .wide)
  }
}

#endif

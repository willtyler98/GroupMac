//
//  Fonts.swift
//  GroupMac
//
//  Created by Will Tyler on 6/29/18.
//  Copyright © 2018 Will Tyler. All rights reserved.
//

import Cocoa


struct Fonts {

	private struct names {
		static let regular = "Segoe UI"
		static let bold = "Segoe UI Bold"
		static let groupMe = "icomoon"
	}

	static let regular = NSFont(name: names.regular, size: 15)!
	static let regularSmall = NSFont(name: names.regular, size: 12)!
	static let regularLarge = NSFont(name: names.regular, size: 18)!
	static let bold = NSFont(name: names.bold, size: 15)!
	static let likesCount = NSFont(name: names.bold, size: 12)!
	static let boldSmall = NSFont(name: names.bold, size: 13)!
	static let boldLarge = NSFont(name: names.bold, size: 18)!
	static let groupMeSymbols = NSFont(name: names.groupMe, size: NSFont.systemFontSize(for: .regular))!

}

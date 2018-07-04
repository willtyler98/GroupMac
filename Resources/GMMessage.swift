//
//  GMMessage.swift
//  GroupMac
//
//  Created by Will Tyler on 6/26/18.
//  Copyright © 2018 Will Tyler. All rights reserved.
//

import Foundation


protocol GMMessage {
	var name: String { get }
	var text: String? { get }
	var avatarURL: URL? { get }
	var isSystem: Bool { get }
}

extension GroupMe.Chat.Message: GMMessage {
	var isSystem: Bool {
		get {
			return false
		}
	}
}
extension GroupMe.Group.Message: GMMessage {}

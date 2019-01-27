//
//  ConvoViewController.swift
//  GroupMac
//
//  Created by Will Tyler on 6/20/18.
//  Copyright © 2018 Will Tyler. All rights reserved.
//

import AppKit


final class ConvoViewController: NSViewController, MessagesViewDelegate {

	private lazy var welcomeLabel: NSTextField = {
		let welcome =
				"""
				You look great today.
				Pop open a chat to start the conversation.
				"""
		let field = NSTextField(wrappingLabelWithString: welcome)

		field.isEditable = false
		field.alignment = .center
		field.font = Fonts.regularLarge

		GroupMe.handleMe(with: { me in
			if let firstName = me.name.split(separator: " ").first {
				DispatchQueue.main.async {
					field.stringValue =
							"""
							You look great today, \(firstName).
							Pop open a chat to start the conversation.
							"""
				}
			}
		})

		return field
	}()
	private lazy var convoHeaderView = ConvoHeaderView()
	private lazy var messagesView = MessagesView(delegate: self)
	private lazy var messageComposerView = MessageComposerView()

	private func setupInitialLayout() {
		view.removeSubviews()

		view.addSubview(welcomeLabel)

		welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
		welcomeLabel.heightAnchor.constraint(equalToConstant: welcomeLabel.intrinsicContentSize.height).isActive = true
		welcomeLabel.widthAnchor.constraint(equalToConstant: welcomeLabel.intrinsicContentSize.width).isActive = true
		welcomeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
		welcomeLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
	}
	private func setupDetailLayout() {
		view.removeSubviews()

		let headerView = convoHeaderView
		let composerView = messageComposerView

		view.addSubview(messagesView) // add messages first because we want message to overlap header for border
		view.addSubview(headerView)
		view.addSubview(composerView)

		headerView.translatesAutoresizingMaskIntoConstraints = false
		headerView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
		headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
		headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
		headerView.heightAnchor.constraint(equalToConstant: 38).isActive = true

		messagesView.translatesAutoresizingMaskIntoConstraints = false
		messagesView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -1).isActive = true // overlap borders
		messagesView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
		messagesView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
		messagesView.bottomAnchor.constraint(equalTo: composerView.topAnchor, constant: 1).isActive = true // overlap borders

		composerView.translatesAutoresizingMaskIntoConstraints = false
		composerView.heightAnchor.constraint(equalToConstant: 38).isActive = true
		composerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
		composerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
		composerView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
	}

	override func loadView() {
		view = NSView()
		view.wantsLayer = true
	}
	override func viewDidLoad() {
		super.viewDidLoad()

		setupInitialLayout()
	}

	private var hasSelectedConvo = false
	var conversation: GMConversation! {
		didSet {
			if !hasSelectedConvo {
				setupDetailLayout()
				hasSelectedConvo = true
			}

			conversation.handleMessages(with: { messages in
				self.messagesView.messages = messages
			}, beforeID: nil)
			convoHeaderView.conversation = conversation
			messageComposerView.conversation = conversation
		}
	}

	// MessagesViewDelegate
	func shouldInsertMoreMessages() {
		if let oldestMessage = messagesView.messages.first {
			conversation.handleMessages(with: { messages in
				self.messagesView.messages.insert(contentsOf: messages, at: 0)
			}, beforeID: oldestMessage.id)
		}
	}

}

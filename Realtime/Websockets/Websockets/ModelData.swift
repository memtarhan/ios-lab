//
//  ModelData.swift
//  Websockets
//
//  Created by Mehmet Tarhan on 28/05/2023.
//

import Combine
import SwiftUI

class ModelData: ObservableObject {
    @Published var messages: [String] = []

    private var webSocketConnection: WebSocketConnection

    init() {
        webSocketConnection = WebSocketTaskConnection(url: URL(string: "ws://localhost:8000/channel-1/\(UUID().uuidString)")!)
        webSocketConnection.delegate = self

        webSocketConnection.connect()

        webSocketConnection.send(text: "Hey, I'm here")
    }
    
    func send(message: String) {
        self.webSocketConnection.send(text: message)
    }
}

extension ModelData: WebSocketConnectionDelegate {
    func onConnected(connection: WebSocketConnection) {
        print("Connected")
    }

    func onDisconnected(connection: WebSocketConnection, error: Error?) {
        if let error = error {
            print("Disconnected with error:\(error)")
        } else {
            print("Disconnected normally")
        }
    }

    func onError(connection: WebSocketConnection, error: Error) {
        print("Connection error:\(error)")
    }

    func onMessage(connection: WebSocketConnection, text: String) {
        print("Text message: \(text)")
        DispatchQueue.main.async {
            self.messages.append(text)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//            self.webSocketConnection.send(text: "ping")
        }
    }

    func onMessage(connection: WebSocketConnection, data: Data) {
        print("Data message: \(data)")
    }
}

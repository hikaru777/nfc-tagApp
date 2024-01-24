//
//  CodableNFCSession.swift
//  wed-nfc
//
//  Created by Kyoya Yamaguchi on 2024/01/15.
//

import Foundation
import CoreNFC

struct TagData: Codable {
    var text: String
    var number: Int
}

class CodableNFCManager: NSObject {
    
    static let shared = CodableNFCManager()
    
    private var session: NFCNDEFReaderSession!
    private var isWriting = false
    private var ndefMessage: NFCNDEFMessage!
    private var writeHandler: (() -> Void)?
    private var readHandler: ((TagData?) -> Void)!
    
    func write(tagData: TagData, _ handler: (() -> Void)? = nil) {
        writeHandler = handler
        isWriting = true
        let data = try! JSONEncoder().encode(tagData)
        let textPayload = NFCNDEFPayload(
            format: NFCTypeNameFormat.nfcWellKnown,
            type: "T".data(using: .utf8)!,
            identifier: Data(),
            payload: data)
        ndefMessage = NFCNDEFMessage(records: [textPayload])
        startSession()
    }
    
    func read(_ handler: @escaping ((TagData?) -> Void)) {
        self.readHandler = handler
        isWriting = false
        startSession()
    }
    
    private func startSession() {
        guard NFCNDEFReaderSession.readingAvailable else {
            return
        }
        session = NFCNDEFReaderSession(delegate: self, queue: nil, invalidateAfterFirstRead: false)
        session.alertMessage = "スキャン中"
        session.begin()
    }
}

extension CodableNFCManager: NFCNDEFReaderSessionDelegate {
    
    func readerSession(_ session: NFCNDEFReaderSession, didDetectNDEFs messages: [NFCNDEFMessage]) {
    }
    
    func readerSession(_ session: NFCNDEFReaderSession, didInvalidateWithError error: Error) {
    }
    
    func readerSessionDidBecomeActive(_ session: NFCNDEFReaderSession) {
    }
    
    func readerSession(_ session: NFCNDEFReaderSession, didDetect tags: [NFCNDEFTag]) {
        let tag = tags.first!
        session.connect(to: tag) { error in
            tag.queryNDEFStatus() { [unowned self] status, capacity, error in
                if isWriting {
                    write(tag: tag, session: session)
                } else {
                    read(tag: tag, session: session)
                }
            }
        }
    }
    
    private func write(tag: NFCNDEFTag, session: NFCNDEFReaderSession) {
        tag.writeNDEF(self.ndefMessage) { [unowned self] error in
            session.alertMessage = "書き込み完了"
            session.invalidate()
            DispatchQueue.main.async {
                (self.writeHandler ?? {})()
            }
        }
    }
    
    private func read(tag: NFCNDEFTag, session: NFCNDEFReaderSession) {
        tag.readNDEF { [unowned self] message, error in
            session.alertMessage = "読み込み完了"
            session.invalidate()
            DispatchQueue.main.async {
                guard let payload = message?.records.first?.payload, let decodedData = try? JSONDecoder().decode(TagData.self, from: payload) else {
                    self.readHandler(nil)
                    return
                }
                self.readHandler(decodedData)
            }
        }
    }
}


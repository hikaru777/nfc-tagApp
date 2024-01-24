import Foundation
import CoreNFC

class NFCManager: NSObject {
    
    static let shared = NFCManager()
    
    private var session: NFCNDEFReaderSession!
    private var isWriting = false
    private var ndefMessage: NFCNDEFMessage!
    private var writeHandler: (() -> Void)?
    private var readHandler: ((String?) -> Void)!
    
    func write(text: String, handler: (() -> Void)? = nil) {
        writeHandler = handler
        isWriting = true
        let textPayload = NFCNDEFPayload(
            format: NFCTypeNameFormat.nfcWellKnown,
            type: "T".data(using: .utf8)!,
            identifier: Data(),
            payload: text.data(using: .utf8)!)
        ndefMessage = NFCNDEFMessage(records: [textPayload])
        startSession()
    }
    
    func read(handler: @escaping ((String?) -> Void)) {
        readHandler = handler
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

extension NFCManager: NFCNDEFReaderSessionDelegate {
    
    func readerSession(_ session: NFCNDEFReaderSession, didDetectNDEFs messages: [NFCNDEFMessage]) {
    }
    
    func readerSession(_ session: NFCNDEFReaderSession, didInvalidateWithError error: Error) {
    }
    
    func readerSessionDidBecomeActive(_ session: NFCNDEFReaderSession) {
    }
    
    func readerSession(_ session: NFCNDEFReaderSession, didDetect tags: [NFCNDEFTag]) {
        let tag = tags.first!
        session.connect(to: tag) { error in
            tag.queryNDEFStatus() { [unowned self] _, _, _ in
                if isWriting {
                    write(tag: tag, session: session)
                } else {
                    read(tag: tag, session: session)
                }
            }
        }
    }
    
    private func write(tag: NFCNDEFTag, session: NFCNDEFReaderSession) {
        tag.writeNDEF(self.ndefMessage) { [unowned self] _ in
            session.alertMessage = "書き込み完了"
            session.invalidate()
            DispatchQueue.main.async {
                (self.writeHandler ?? {})()
            }
        }
    }
    
    private func read(tag: NFCNDEFTag, session: NFCNDEFReaderSession) {
        tag.readNDEF { [unowned self] message, _ in
            session.alertMessage = "読み込み完了"
            session.invalidate()
            DispatchQueue.main.async {
                guard let payload = message?.records.first?.payload, let text = String(data: payload, encoding: .utf8) else {
                    self.readHandler(nil)
                    return
                }
                self.readHandler(text)
            }
        }
    }
}

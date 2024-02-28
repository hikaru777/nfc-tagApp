import Foundation

extension Sequence {
    func asyncCompactMap<T>(
        _ transform: @escaping (Element) async throws -> T?
    ) async rethrows -> [T] {
        return try await withThrowingTaskGroup(of: (Int, T)?.self) { group in
            var transformedElements = [Int: T]()

            for (i, element) in self.enumerated() {
                group.addTask {
                    if let transformed = try? await transform(element) {
                        return (i, transformed)
                    }
                    return nil
                }
            }

            for try await transformedElement in group {
                if let transformedElement {
                    transformedElements[transformedElement.0] = transformedElement.1
                }
            }

            return transformedElements.sorted {
                $0.key < $1.key
            }.map (\.value)
        }
    }
}

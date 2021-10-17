import Foundation

extension Thread {
    func set(name: String) {
        pthread_setname_np(name)
    }
}

import Promises

public class LocalTrack: Track {

    /// ``publishOptions`` used for this track if already published.
    public internal(set) var publishOptions: PublishOptions?

    public func mute() -> Promise<Void> {
        // Already muted
        if muted { return Promise(()) }

        return disable().then(on: .sdk) {
            self.stop()
        }.then(on: .sdk) {
            self.set(muted: true, shouldSendSignal: true)
        }
    }

    public func unmute() -> Promise<Void> {
        // Already un-muted
        if !muted { return Promise(()) }

        return enable().then(on: .sdk) {
            self.start()
        }.then(on: .sdk) {
            self.set(muted: false, shouldSendSignal: true)
        }
    }
}

//
//  Created by Dmitry Troshkin on 01.11.2022
//  Copyright © Pavel Lipnyagov & Karina Lipnyagova. All rights reserved.

import Foundation
import AVFoundation

class SamplerPlayer {

    // MARK: - Private Properties

    private var engine: AVAudioEngine!
    private var sampler: AVAudioUnitSampler!

    // MARK: - Lifecycle

    init() {
        makeAndStartEngine()
        addObservers()
        activateAudioSession()
    }

    deinit {
        removeObservers()
    }

    // MARK: - Public

    public func play() {
        sampler.startNote(60, withVelocity: 64, onChannel: 0)
    }

    public func stop() {
        sampler.stopNote(60, onChannel: 0)
    }

    // MARK: - Private

    private func makeAndStartEngine() {
        engine = AVAudioEngine()
        sampler = AVAudioUnitSampler()
        engine.attach(sampler)
        engine.connect(sampler, to: engine.mainMixerNode, format: nil)
        loadEXSFile()
        startEngine()
    }

    private func loadEXSFile() {
        guard
            let url = Bundle.main.url(forResource: "HangDrum01", withExtension: "exs")
        else {
            print("could not load file")

            return
        }

        do {
            try sampler.loadInstrument(at: url)
        } catch {
            print(error.localizedDescription)
        }

    }

    private func activateAudioSession() {
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(.playback, mode: .default, options: [])
            try audioSession.setActive(true)
        } catch {
            debugPrint("Failed to activate audio session: \(error.localizedDescription)")
        }
    }

    private func startEngine() {
        if engine.isRunning {
            print("audio engine already started")
            return
        }

        do {
            try engine.start()
        } catch {
            print("could not start audio engine: \(error.localizedDescription)")
        }
    }

    private func stopEngine() {
        if engine.isRunning {
            engine.stop()
        }
    }

    // MARK: - Observers

    private func addObservers() {
        let audioSession = AVAudioSession.sharedInstance()
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleInterruption),
            name: AVAudioSession.interruptionNotification,
            object: audioSession)

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleMediaServicesWereReset),
            name: AVAudioSession.mediaServicesWereResetNotification,
            object: audioSession)
    }

    private func removeObservers() {
        let audioSession = AVAudioSession.sharedInstance()
        NotificationCenter.default.removeObserver(
            self,
            name: AVAudioSession.interruptionNotification,
            object: audioSession)

        NotificationCenter.default.removeObserver(
            self,
            name: AVAudioSession.mediaServicesWereResetNotification,
            object: audioSession)
    }

    @objc private func handleInterruption(_ notification: Notification) {
        guard let type = notification.interruptionType else { return }
        if type == .began {
            stop()
        } else {
            activateAudioSession()
            makeAndStartEngine()
        }
    }

    @objc private func handleMediaServicesWereReset(_ notification: Notification) {
        stopEngine()
        activateAudioSession()
        makeAndStartEngine()
    }

}

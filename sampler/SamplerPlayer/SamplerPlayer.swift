//
//  Created by Dmitry Troshkin on 01.11.2022
//  Copyright © Pavel Lipnyagov & Karina Lipnyagova. All rights reserved.

import Foundation
import AVFoundation

class SamplerPlayer {

    var latestPlayedNote: UInt8 = 0

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

    public func play(note: UInt8) {
        print("Sampler should play note: ", note)
        latestPlayedNote = note
        sampler.startNote(note, withVelocity: 64, onChannel: 0)
    }

    public func stop(note: UInt8) {
        print("Sampler should stop note: ", note)
        sampler.stopNote(note, onChannel: 0)
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

        // FILE 1:
        // File from irekid, from Logic
        // Using audio files from AppBundle/EXS Factory Samples/...
        let resourceName = "HangDrum01"

        // FILE 2:
        // File from /Library/Application Support/GarageBand/Instrument Library/Sampler/Sampler Instruments/
        // Audio files are from /Library/Application Support/GarageBand/Instrument Library/Sampler/Sampler Files/Flute Solo
        // Using audio files from AppBundle/Sampler Files/...
        //let resourceName = "Flute iOS KB"

        guard
            let instrumentBundleURL = Bundle.main.url(forResource: resourceName, withExtension: "exs")
        else {
            print("could not load file instrumentBundleURL")

            return
        }

        print("URL of instrument = ", instrumentBundleURL.path)

        do {
            try sampler.loadInstrument(at: instrumentBundleURL)
        } catch {
            print("Failed to load instrument ", error.localizedDescription)
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
            stop(note: latestPlayedNote)
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

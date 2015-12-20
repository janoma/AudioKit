//: [TOC](Table%20Of%20Contents) | [Previous](@previous) | [Next](@next)
//:
//: ---
//:
//: ## Sampler Instrument - EXS24
//: ### Loading a sampler with an EXS24 instrument

import XCPlayground
import AudioKit

let audiokit = AKManager.sharedInstance

let pulse = 0.5 // seconds

//: We are going to load an EXS24 instrument and send it random notes

let sampler = AKSampler()

//: Here is where we reference the EXS24 file as it is in the app bundle
sampler.loadEXS24("Sounds/sawPiano1")

let delay  = AKDelay(sampler)
delay.time = pulse * 1.5
delay.dryWetMix = 30
delay.feedback = 20

let reverb = AKReverb(delay)

//: Connect the sampler to the main output
audiokit.audioOutput = reverb
audiokit.start()

//: This is a loop to send a random note to the sampler
//: The sampler 'playNote' function is very useful here
let updater = AKPlaygroundLoop(every: pulse) {
    let scale = [0,2,4,5,7,9,11,12]
    var note = scale.randomElement()
    let octave = randomInt(3...7)  * 12
    if randomFloat(0, 10) < 1.0 { note++ }
    if !scale.contains(note % 12) { print("ACCIDENT!") }
    if randomFloat(0, 6) > 1.0 { sampler.playNote(note + octave) }
}

XCPlaygroundPage.currentPage.needsIndefiniteExecution = true
//: [TOC](Table%20Of%20Contents) | [Previous](@previous) | [Next](@next)
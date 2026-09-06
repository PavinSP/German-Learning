# Voice Mode — working configuration

Set up 2026-09-06. Real two-way voice inside the Claude Code session, so spoken
errors land in ERROR_LOG.md automatically instead of being reported back by hand.

---

## Critical settings

**Use `disable_silence_detection: true` with a fixed listening window.**
This is the setting that actually works reliably. Pass
`listen_duration_min` equal (or close) to `listen_duration_max` — e.g. both
around 10-12s per question — so the microphone stays open for a guaranteed
period regardless of what the VAD thinks. Without it the two chimes fire
back-to-back with no usable gap and the answer is lost.

**`vad_aggressiveness: 0` as well.**
The default voice-activity detection is too aggressive for this Mac's mic level
and discards speech as silence — "No speech detected" even though capture works
fine. Measured input peaked around −47 dB where speech should reach −10 to −20 dB.
Necessary but, on its own, **not sufficient** — the silence-detection setting above
is what made it dependable.

**`VOICEMODE_WHISPER_LANGUAGE=de`** — set in the MCP server's env in
`~/.claude.json`. Without it Whisper defaults to English and transcribes German
phonetically: "Hallo, ich heiße Pavin" came back as `HALO, ISH HAI SAPAVIN`.

**Input volume raised to 90** (`osascript -e 'set volume input volume 90'`).
Was at 53. Helps but was not sufficient alone — the VAD setting was the real fix.

---

## Installed components

| Piece | Status |
|---|---|
| portaudio, ffmpeg, node, Python 3.13, uv | ✅ installed |
| MCP server `voicemode` | ✅ registered, user scope |
| OpenAI API key | ✅ in `~/.config/voicemode/env`, chmod 600 |
| whisper-1 / tts-1 / gpt-4o-mini-transcribe | ✅ available on the key |

The **plugin** version (`voicemode@voicemode`) was installed first and then
removed — having both it and the manual `claude mcp add` registration created a
duplicate server that failed to connect. Use one or the other, not both.

---

## Still open — native German TTS

OpenAI voices speak German **with an American accent**, which is a poor
pronunciation model for a learner. Kokoro runs locally and free, and provides
German voices: **`gm_hans`** (male), **`gf_lisa`** (female). Not yet installed —
`service(service_name="kokoro", action="status")` returns "not available".

Two reasons to do this eventually:
1. Accent — the learner hears whatever model we give them.
2. Cost — TTS is roughly 60% of the estimated €3/month; Kokoro is free.

Usage once installed: `converse(..., voice="gm_hans", tts_provider="kokoro")`.

---

## Costs

Prepaid $5.95 (incl. VAT) on 2026-09-06. Non-refundable, expires in one year.
Estimated ~€3/month at 15 min/day. **Watch actual usage for the first week** —
that estimate is unverified arithmetic, not measurement.

---

## Known limitation, stated plainly

Speech-to-text transcribes **what you meant, not what you said**. Whisper is
trained to produce plausible text, so it will quietly repair mispronunciation.
That means voice practice here trains *fluency and retrieval speed* — genuinely
the main conversational bottleneck — but it does **not** give reliable
pronunciation correction. For that, a human or a dedicated pronunciation tool
is still needed.

**Demonstrated on day one, and it matters more than expected.** The learner
spoke "Er gebt mir das Buch" (wrong — gebt is the ihr-form). Whisper transcribed
it as "gibt", the *correct* form. The error was invisible until the same sentence
was typed out. **Voice cannot be used to check conjugation endings, article
endings, or any fine morphology** — STT outputs plausible German, which means it
repairs exactly what a grammar check is looking for.

Use voice for what it is genuinely good at: retrieval speed, fluency, word order,
vocabulary reach, and willingness to produce. Check endings in writing.

**And it cuts the other way too.** On 2026-09-06 "Er gibt mir das Buch" came
back twice, identically, as `hier gibt Mia das Buch`. Whisper is deterministic
enough that re-asking reproduces the same mishearing — so a garbled transcript
cannot be fixed by repeating it. When a reply looks wrong in a way that smells
phonetic (Er→hier, mir→Mia), **ask the learner to type that one sentence**
rather than marking it wrong or re-asking by voice.

## Session log

**2026-09-06, first real use — dative check.** 8 spoken answers across two
surveys. Roughly 95 seconds of recorded audio ≈ $0.01 of transcription, plus
TTS — comfortably inside the €3/month estimate. Findings: dative/accusative
inversion in a giving sentence (corrected on one retry), `euch` produced for
the first time, and "den Buch" confirming the den-for-das-word pattern.

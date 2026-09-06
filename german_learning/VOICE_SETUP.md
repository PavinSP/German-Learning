# Voice Mode — working configuration

Set up 2026-09-06. Real two-way voice inside the Claude Code session, so spoken
errors land in ERROR_LOG.md automatically instead of being reported back by hand.

---

## The working config — use this

Confirmed good 2026-09-06. Natural turn-taking, German-sounding male voice,
learner approved both the accent and the speed.

```
voice:               "onyx"
tts_model:           "gpt-4o-mini-tts"
tts_instructions:    <the German-accent prompt below>
vad_aggressiveness:  0
listen_duration_min: 10
listen_duration_max: 35
```
Leave `speed` unset — the default pace was explicitly approved.

**tts_instructions that produced the good accent:**

> You are a native German speaker. Pronounce all German words with authentic
> native German pronunciation - proper umlauts, guttural ch, rolled or uvular r,
> and correct German vowel quality. Speak the English parts with a light German
> accent. Moderate pace, clear articulation, warm and encouraging like a
> language tutor.

**Do NOT set `disable_silence_detection` for conversation.** It forces the mic
to stay open for the full window, which makes every exchange feel sluggish and
unnatural — the learner noticed immediately.

**But `listen_duration_min` must be ~10, not 3.** At 3 the learner was cut off
mid-sentence while still thinking ("Ich sehe die W."). At 10 it waits through
thinking-pauses and still ends naturally when he actually finishes — 10.4s
recorded out of a 35s window. A beginner pauses mid-sentence; the minimum has
to absorb that.

**Where the fixed window IS still right:** multi-question surveys via `turns`,
where the learner needs guaranteed thinking time per question and there is no
back-and-forth to feel sluggish.

**Why `vad_aggressiveness: 0` is non-negotiable.**
The default is too aggressive for this Mac's mic level and discards speech as
silence — "No speech detected" even though capture works fine. Measured input
peaked around −47 dB where speech should reach −10 to −20 dB.

**`VOICEMODE_WHISPER_LANGUAGE=de`** — set in the MCP server's env in
`~/.claude.json`. Without it Whisper defaults to English and transcribes German
phonetically: "Hallo, ich heiße Pavin" came back as `HALO, ISH HAI SAPAVIN`.

**Instruction language: ENGLISH.** The learner stopped a fully-German opening
on 2026-09-06 — he doesn't understand enough yet. Give instructions and
corrections in English; he produces the German.

**Input volume raised to 90** (`osascript -e 'set volume input volume 90'`).
Was at 53. Helps but was not sufficient alone — the VAD setting was the real fix.

---

## Local models — mlx-audio (installed 2026-09-06)

`mlx-audio` is a unified Whisper STT + Kokoro TTS package built for Apple
Silicon. Installed via `voicemode service install mlx-audio`, runs on
**port 8890**, and is **enabled at login** (LaunchAgent at
`~/Library/LaunchAgents/com.voicemode.mlx-audio.plist`).

This replaces the OpenAI API for both halves:
- **Zero cost** per session
- **No network round trip** — OpenAI STT was ~2.3s per turn
- **Real German voices** (`gm_hans` male, `gf_lisa` female) instead of an
  English voice imitating an accent via tts_instructions

Hardware here is an M4 Pro / 24GB, comfortably above requirements.

**voicemode only discovers services at startup** — after installing or
restarting mlx-audio, Claude Code must be restarted before it routes locally.
Check which provider was actually used: the converse result prints `STT: openai`
or the local provider.

The $5.95 OpenAI credit remains as a fallback and does not expire for a year.

Usage once local: `converse(..., voice="gm_hans", tts_provider="kokoro")`.

**Unchanged limitation:** local Whisper still transcribes intent rather than
sound, so endings still cannot be verified by voice. That is inherent to STT.

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

**Largely solved without it** — `gpt-4o-mini-tts` with the German-accent
instructions above produced a voice the learner judged "really good" on
2026-09-06, so the accent argument for Kokoro is much weaker now.

The remaining reason is **cost**: TTS is roughly 60% of the estimated €3/month
and Kokoro is free and local. Voices: **`gm_hans`** (male), **`gf_lisa`**
(female). Not installed — `service(service_name="kokoro", action="status")`
returns "not available". Worth revisiting only if the bill turns out higher
than estimated.

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

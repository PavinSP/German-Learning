# Voice Mode — working configuration

Set up 2026-09-06. Real two-way voice inside the Claude Code session, so spoken
errors land in ERROR_LOG.md automatically instead of being reported back by hand.

---

## Critical settings

**`vad_aggressiveness: 0` on every `converse` call.**
This was the whole problem on first setup. The default voice-activity detection
is too aggressive for this Mac's microphone level and discards the speech as
silence — the result is "No speech detected" even though the mic is working
perfectly. Measured input peaked around −47 dB where normal speech should reach
−10 to −20 dB. Setting aggressiveness to 0 (most permissive) fixed it instantly.

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

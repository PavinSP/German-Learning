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
**Leave `speed` unset.** Tried `speed: 0.85` on 2026-09-06 and the learner
rejected it: it sounds *stretched*, like slowing a recording rather than someone
speaking more slowly. Default pace was explicitly approved.

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

**Let him speak unprompted with `skip_tts`.** Pass
`converse(message="listening", skip_tts=true, listen_duration_min=12, ...)` —
this opens the mic with zero speech from the assistant. Without it the mic only
ever opens in reply to an assistant question, so he can never start a topic or
interject. He raised this himself on 2026-09-06.

**Conversational mode currently does NOT transcribe reliably (2026-09-06).**
Careful, isolated, German-only sentences transcribe perfectly. Natural
conversation does not — three consecutive exchanges came back as mush
("Ich esse Hähnchen mit Reis" → `it's a henshan mit rice`). It breaks
specifically on **newly-learned words**, where his pronunciation is least
settled, which means quality degrades exactly where feedback matters most.
English filler mixed into German utterances ("yeah", "hello") makes it worse,
since language is force-set to `de`.

**When a transcript is unreadable, say so — do not reconstruct and reply as if
you understood.** Guessing turns tutoring into nonsense and risks logging
phantom errors.

**Open test:** STT base URLs have been flipped to prefer OpenAI over local, to
find out whether local `large-v3-turbo` is simply worse here (its CoreML encoder
was never downloaded, so it runs unoptimised). OpenAI transcribed him flawlessly
earlier the same day. Compare on the same sentence after the next restart.

**DO NOT USE `turns` SURVEY MODE FOR GERMAN.** Verified 2026-09-06: the survey
path does not apply `VOICEMODE_WHISPER_LANGUAGE=de`. In one 4-question survey,
three answers came back as English phonetic mush or translations
("Ich sehe den Mann" → *"I say her then man"*; "Wo ist mein Buch?" →
*"Where is my book?"*), while the same sentence in a SINGLE `converse` call
transcribed perfectly moments later. It is not sentence length — it is the code
path.

**Use single `converse` calls for German, one question at a time.** The cost is
the assistant's own composition time between turns, which is the main source of
perceived latency. Keep spoken replies to a few words to minimise it; save
detailed corrections for text afterwards.

**Why `vad_aggressiveness: 0` is non-negotiable.**
The default is too aggressive for this Mac's mic level and discards speech as
silence — "No speech detected" even though capture works fine. Measured input
peaked around −47 dB where speech should reach −10 to −20 dB.

**Language: `VOICEMODE_WHISPER_LANGUAGE=de`** in `~/.voicemode/voicemode.env`.
This took three attempts to get right, so the reasoning is worth keeping:

- **Unset (defaults to English):** German came back as phonetic nonsense —
  "Hallo, ich heiße Pavin" → `HALO, ISH HAI SAPAVIN`.
- **`auto`:** local whisper *translated* German into English instead of
  transcribing it. He said "Ich esse Brot und trinke einen Kaffee" and it
  returned "So I eat some bread and drink a coffee." Useless for grading.
- **`de`:** correct. German transcribes as German.

**The known cost of `de`:** English speech gets rendered INTO German. On
2026-09-06 an English answer came back as fluent German with subordinate
clauses and Konjunktiv II, far beyond his level — briefly alarming until the
cause was clear. Accepted deliberately: his German being translated away is
worse than his English asides being mangled, since German production is the
whole point. **If a transcript looks implausibly advanced, suspect this before
believing it.**

**Instruction language: ENGLISH.** The learner stopped a fully-German opening
on 2026-09-06 — he doesn't understand enough yet. Give instructions and
corrections in English; he produces the German.

**Input volume raised to 90** (`osascript -e 'set volume input volume 90'`).
Was at 53. Helps but was not sufficient alone — the VAD setting was the real fix.

---

## Local models — final setup (2026-09-06)

**Hybrid: local STT, cloud TTS.** Arrived at after trying several combinations.

| | Provider | Why |
|---|---|---|
| **STT** | **local whisper.cpp, port 2022** | Free, on-device, CoreML-accelerated on Apple Silicon, no network round trip |
| **TTS** | **OpenAI `gpt-4o-mini-tts`** | Kokoro has NO German voices (see below); the learner approved the OpenAI voice |

Config in `~/.voicemode/voicemode.env`:
```
VOICEMODE_STT_BASE_URLS=http://127.0.0.1:2022/v1,https://api.openai.com/v1
VOICEMODE_TTS_BASE_URLS=https://api.openai.com/v1
VOICEMODE_PREFER_LOCAL=true
VOICEMODE_ALWAYS_TRY_LOCAL=true
```
Whisper is enabled at login (LaunchAgent `com.voicemode.whisper.plist`).

**Model: `large-v3-turbo`, NOT `base`.** The installer defaults to `base` (141MB)
and its German is unusable — on the first live test it rendered a simple German
sentence as *"Hello, isha is a problem, isha is a rice."* OpenAI's hosted
whisper-1 is a far larger model, which is why the cloud version was accurate.
`large-v3-turbo` (~1.6GB) gives near-large accuracy at high speed and runs
comfortably on an M4 Pro. Set via `VOICEMODE_WHISPER_MODEL` in voicemode.env.

**Speed, measured:** local STT returns in **1.2-1.4s** on large-v3-turbo, vs
2.3-3.3s via OpenAI. (The `base` model was 0.3s but its German was unusable.)
The CoreML encoder for large-v3-turbo is NOT downloaded — it runs on Metal/CPU
and is fast enough. `models/download-coreml-model.sh large-v3-turbo` would
speed it up further if ever needed.

**Final verified state, 2026-09-06:** German in → German out, 1.2s, `STT: whisper`.

### Two dead ends, recorded so they are not repeated

**1. mlx-audio does not work with voicemode.** It installs and runs fine (port
8890, endpoints valid), but **voicemode's provider detection only recognises two
names — `whisper` on 2022 and `kokoro` on 8880**. mlx-audio is invisible to it,
so every request fell through to OpenAI regardless of how the base URLs were set.
One turn took 63.5s for STT because of failed probing against dead ports.
Installed, then stopped and disabled.

**2. Kokoro has no German voices — the documentation is wrong.**
`voicemode://docs/languages` lists `gm_hans` (male) and `gf_lisa` (female) under
German. The actual installed build serves **67 voices and none of them are
German**: prefixes are af/am (American), bf/bm (British), ef/em (Spanish), ff
(French), hf/hm (Hindi), if/im (Italian), jf/jm (Japanese), pf/pm (Portuguese),
zf/zm (Chinese). Verified directly against `/v1/audio/voices`.

So the "native German voice" argument for Kokoro is void. TTS stays on OpenAI,
where `gpt-4o-mini-tts` plus explicit German-pronunciation instructions produced
a voice the learner judged "really good". Kokoro installed, then stopped and
disabled.

### Cost after this change
STT moves off the API entirely. TTS remains, at $15/1M characters — the smaller
half of a bill that was already about $0.03/session. The $5.95 prepaid credit
will last a very long time.

**Unchanged limitation:** local Whisper still transcribes intent rather than
sound, so endings still cannot be verified by voice. That is inherent to STT,
not to any particular provider.

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

## Costs

Prepaid $5.95 (incl. VAT) on 2026-09-06. Non-refundable, expires in one year.
Actual usage on setup day: about **$0.03** across a dozen exchanges. With STT
now local, only TTS bills — so the credit should last many months.

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

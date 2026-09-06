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

## Providers — FINAL (settled 2026-09-06 by direct A/B test)

**Both STT and TTS run on OpenAI. All local models were tried and abandoned.**

```
VOICEMODE_STT_BASE_URLS=https://api.openai.com/v1
VOICEMODE_TTS_BASE_URLS=https://api.openai.com/v1
VOICEMODE_PREFER_LOCAL=false
VOICEMODE_ALWAYS_TRY_LOCAL=false
```

### The A/B test that settled it
Same sentence, "Ich esse Hähnchen mit Reis", spoken minutes apart:

| Provider | Transcript | Latency |
|---|---|---|
| local whisper `large-v3-turbo` | `it's a henshan mit rice` | 1.2s |
| **OpenAI** | **„Es ist ein Händchen mit Reis."** | **0.8s** |

Local produced English mush; OpenAI produced grammatical German with correct
umlauts. **OpenAI was also faster.** Local whisper was a false economy on both
axes — it was not merely cheaper-and-worse, it was worse *and* slower.

(OpenAI still misheard "Ich esse" as "Es ist ein" and Hähnchen as Händchen —
but that is workable German to correct against, not gibberish.)

### Everything local was tried and disabled
1. **mlx-audio** — voicemode's provider detection only recognises `whisper`:2022
   and `kokoro`:8880, so it was invisible on 8890 and everything silently fell
   through to OpenAI anyway. One turn took 63.5s from failed probing.
2. **Kokoro** — has **no German voices**, contrary to voicemode's own docs which
   list `gm_hans` and `gf_lisa`. Verified against `/v1/audio/voices`: 67 voices,
   none German.
3. **whisper.cpp local** — `base` model's German was unusable
   ("isha is a rice"); `large-v3-turbo` was better but still far behind OpenAI,
   as the table above shows. Its CoreML encoder never downloaded, so it ran
   unoptimised, but the gap was too large for that to be the whole story.

All three services are stopped and disabled. Their LaunchAgents are removed.

### Cost
$0.006/min transcription plus TTS at $15/1M characters. Whole setup day,
including dozens of exchanges and all the debugging: **about $0.03**. The $5.95
prepaid credit will last months.

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

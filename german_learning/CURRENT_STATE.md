# CURRENT STATE

*Read this file FIRST at the start of every session.*

**From 2026-09-07 the learner studies ~3 hours/day — follow [STUDY_PLAN.md](STUDY_PLAN.md).**
Three spaced ~1hr blocks; **max 2 new grammar concepts per week**; nothing promoted
past LEARNING without holding across a real overnight gap. The extra hours go into
depth per concept, not more concepts. Listening, speaking and daily free writing
are now standing components.

**Standing rules (memory, apply every session):** never infer knowledge from a
voice transcript — STT rewrites toward grammatical German in both directions
(hides real errors, invents fake competence); check endings/morphology in
writing only. Never silently file an answer/correction — always speak it in
the turn itself. Push to GitHub after every turn touching tracker files.

**Also check [VOCAB_PLAN.md](VOCAB_PLAN.md) whenever picking a vocabulary topic** —
it tracks coverage against the Anki A1/A2 reference deck and gives a prioritized
order. Update it (mark lessons covered) after any vocabulary session that draws
from the Anki deck.

**HARD RULE — no status file may go stale (added 2026-09-18, widened
2026-09-19):** Every time you log anything to a tracker (GRAMMAR.md,
ERROR_LOG.md, VOCABULARY.md, ANSWERS.md, daily notes), you must ALSO
(1) update **this file** — the Quick summary table, and the weakness table or
revision schedule if the new material changes either;
(2) update [Complete Notes.md](Complete%20Notes.md) with whatever is new;
(3) refresh [MASTER_PROGRESS.md](MASTER_PROGRESS.md) — at minimum its Current
Status table, plus any section the material actually changes;
(4) run `cd german_learning && ./build_notes.sh` to regenerate
`Complete Notes.tex` and `Complete Notes.pdf`; and (5) commit all of it
together in the same push.

**The general form of the rule, which matters more than the list:** any file
that states the learner's *current* position must be re-read and corrected
whenever that position changes. The 09-18 version of this rule named Complete
Notes and MASTER_PROGRESS but not CURRENT_STATE — and CURRENT_STATE was found
stale the very next morning, still claiming Session 14 with a revision
schedule whose every date had passed. **A rule that enumerates files will miss
whatever is not enumerated.** When auditing, check content against reality,
not commit dates: a file can be freshly committed and still wrong.

*MASTER_PROGRESS.md was allowed to sit 13 days stale (Session 7 while the
real count was 15), claiming listening and speaking were "not yet practiced"
long after both had started. A stale status file is worse than no status file
— it can mislead a future session into re-teaching finished material.*
The learner studies from the PDF — a tracker update not reflected there
means they're revising an outdated picture of their own progress.
**The .tex and .pdf are generated artefacts — never hand-edit them**, edit the
Markdown and rebuild. Build needs pandoc + xelatex (both present). If the
build fails, say so rather than pushing a stale PDF next to fresh notes.

**Token-efficiency convention (added 2026-09-15):** ERROR_LOG.md and SESSION_LOG.md
now hold only ACTIVE/IMPROVING entries and the last 3 sessions respectively.
Resolved entries and older sessions live in `archive/ERROR_LOG_ARCHIVE.md` and
`archive/SESSION_LOG_ARCHIVE.md` — do NOT read the archive files at session
start; only open them if you need historical detail a one-line summary doesn't
cover. Keep applying this convention going forward: when an ERROR_LOG entry
gets marked RESOLVED, move it to the archive same-session rather than leaving
it in the live file; when SESSION_LOG grows past 3 entries, archive the oldest
with a one-line summary rather than letting it grow unbounded.

## Quick summary

| Field | Value |
|---|---|
| **Level** | PRE-A1 / Foundation |
| **Module** | Foundation |
| **Lesson** | Comprehensive review in progress. Perfekt: helper-verb selection FUNCTIONAL, participle spelling LEARNING. Two-way + accusative prepositions both promoted FUNCTIONAL 09-18 |
| **Last session** | 2026-09-18 (Session 15) — comprehensive review Parts 1–3 (38/45); two-way and accusative prepositions both promoted to FUNCTIONAL |
| **Next action** | **Pick up the nicht-placement drill (Q46–52)** — issued at the end of 09-18, not attempted. Then Part 4 onward of the comprehensive review (38/45 so far): the vocabulary sweep and the Perfekt material. Priority fixes after that, in order: weil (both halves in ONE sentence — drilling them separately has failed three times), dative-only verb pronoun forms, es→ihm/sie→ihr, nicht with definite objects |
| **Blocking?** | No |
| **Last full review** | **In progress** — 100+ question full-coverage review, Parts 1–3 done: **38/45.** Part 1 (basics) 15/15, Part 2 (dative) 10/15, Part 3 (prepositions/word order) 13/15. Previous completed review: 37 questions on 2026-09-15, 25/37 |

## Known weaknesses (watch list)

| Item | Status | Note |
|---|---|---|
| **Dative-only verbs** (helfen/danken/gehören) | **ACTIVE REGRESSION** — 3/3 on 09-10, 1/3 on 09-17 | The verbs are *correctly identified* as dative-taking every time — no accusative reasoning is attempted — but the accusative pronoun is reached for anyway (*danke ihn*, *gehört mich*). Drill the FORMS (mir/dir/ihm/ihr), not the concept |
| **es → ihm vs sie → ihr** | **ACTIVE, 3rd occurrence** (09-10, 09-17) | Always the same direction: *ihm* given for both. es shares its dative with er, which is counter-intuitive enough to over-apply. Single slipperiest cell in the pronoun table; needs spaced repetition, not another one-off correction |
| **weil — both halves at once** | **ACTIVE, 3 failures in alternation** | Needs verb-last in its own clause AND verb-second in the main clause. 09-11 the main clause broke; 09-15 and 09-18 the weil-clause broke. Every isolated retest clean. **Both halves have never held together unprompted** — practise them in ONE sentence, not separately |
| den used for das-words | **LOAD-DEPENDENT, not a gap** (reclassified 2026-09-06) | Broke twice by voice ("den Buch"), then a written 8-question accusative check the same day went **8/8**, including two direct probes ("kein Buch" ✅, "das Buch" ✅). He knows the rule cold in writing. Do NOT re-teach — exercise it under load, like the conjugation pattern |
| geben conjugation (gibt) | **RESOLVED — 2026-09-07, real gap, in writing** | 5/5 written, camouflaged among 4 other sentences, after a genuine overnight gap. First check to actually meet the bar (previous two "resolutions" were same-day or voice-only and both reversed). Holds until an equally rigorous check contradicts it |
| Dative: person vs thing case assignment | **CONFIRMED 2026-09-06** | The exact inverted sentence ("Ich gebe ihn dem Hund") came back correct in a written 5/5 round: "Ich gebe ihr den Hund". Still worth one fresh-day probe |
| mögen + verb (should be gern + verb) | Watch, speed-dependent | "Ich mag kochen" → "Ich koche gern". 2nd occurrence, this one under time pressure — mirrors the conjugation pattern (correct when unhurried, slips when fast) |
| 3rd-person vs du conjugation | IMPROVING, load-dependent | 8+ instances, ALL under cognitive load; 3 focused drills, ALL clean. Not a conceptual gap. Do NOT drill in isolation — embed a 3rd-person subject in every mixed round. Recurred again in the 2026-09-04 review (Möchtest, wir können, trägt) |
| Nominative after *sein* (deinen → dein) | REGRESSION, 2026-09-04 | "Ist das deinen Hund?" — after sein the noun stays nominative. Answered directly on 2026-09-01 as ANSWERS.md **Q4**. Re-read that entry rather than re-teaching |
| Invented umlaut on singular nouns (ADDED) | Improving, light | 3 instances (Bröt, Äpfel, Stühl). Did not recur in the 2026-09-03 consolidation round (Stuhl clean). Rule given: singular is the plain form, the umlaut is the plural's job |
| Omitted umlaut (konnen for können) | Light, new — likely friction not knowledge | Logged SEPARATELY from the invented-umlaut entry on purpose: omitting an umlaut is what a phone keyboard produces, whereas ADDING one takes deliberate effort. Retest on a laptop; if it vanishes, downgrade to friction |
| Pronoun selection by grammatical gender | RESOLVED — confirmed FUNCTIONAL 2026-09-04 | Cold check (embedded, 3rd-person subjects, all 3 genders) went 5/5 one day ahead of schedule. No longer a priority item. Full reference: ANSWERS.md Q11 |
| nicht placed before a pronoun object | Resolved, watch once | EN interference (Er sieht nicht uns → Er sieht uns nicht). Clean on retry; re-check when pronouns next meet negation |
| **Free-writing volume / avoidance** | **NEW, 2026-09-06 — first measurement** | Asked for 5-8 sentences, produced 2, both from his most-drilled material. Also substituted English ("Chicken", "Rice") instead of writing `???` as instructed. Structure was clean — **the constraint is vocabulary reach and willingness to attempt, not grammar** |
| Separable prefix capitalized (Fern, Schwimmen) | Pattern, 2 instances | Infinitives and separable prefixes stay lowercase unless genuinely nominalized (das Schwimmen). Worth one explicit statement |
| Modal + infinitive placement | Light | One slip, retested clean once — low priority |
| zum/zur contraction (der/das vs die words) | New, light, likely momentary | "zur Arzt" instead of "zum Arzt" — same day "zum Arzt" was already correct, so read as a slip not a regression. Watch once |
| **Repeated need for a nudge back to already-answered material** | **WATCHING, new 2026-09-11** | Three different topics in two days (es/sie dative swap, two-way prepositions, nach/zu) each taught-and-tested-clean once, then forgotten or confabulated shortly after. Looks like a spacing issue, not conceptual. If a 4th instance appears, consider widening revision spacing across ALL recent topics, not just the one that fails |

## Listening comprehension (NEW, 2026-09-08)

| Episode | Result |
|---|---|
| Nicos Weg Ep.1 "Hallo!" | **Strong first attempt.** Correctly identified the greeting-chain scene, the full bag/"schön" confusion-and-clarification exchange, and the ending (mother intervening, both leaving). Only gap: read the opening greetings as a "podcast" rather than live street dialogue — reasonable inference from audio alone. Confirmed word-for-word against the official DW script. See [daily note](daily_notes/2026-09-08.md) and [Listening/01_Hallo_Nicos_Weg_transcript.md](Listening/01_Hallo_Nicos_Weg_transcript.md) |
| Nicos Weg Ep.2 "Kein Problem" | **Full plot/causal chain correct** (bags placed near each other → taxi driver takes both by mistake → Nico objects), incl. sensing the Königshof hotel/restaurant naming confusion. **One character-attribution mix-up:** attributed the phone call and taxi instructions to Nico; script confirms they belong to an unnamed Mann, with Nico only speaking the final "Hey, stoppl!" line. Not a German-comprehension gap — a who-said-it framing miss. See [Listening/02_Kein_Problem_Nicos_Weg_transcript.md](Listening/02_Kein_Problem_Nicos_Weg_transcript.md) |
| Nicos Weg Ep.3 "Tschüss" | **Strong plot comprehension** — correctly caught the formal/informal goodbye distinction (Auf Wiedersehen vs Tschüss), the mother/daughter (Lisa/Emma) returning to help Nico, and the bag/taxi callback to Ep.2. One unsupported detail ("Nico is Spanish," a "shows a photo" ending) not present in the clip — verified against both transcript and actual video duration (75.8s, nothing missed); likely misremembered from elsewhere, not a real comprehension error. See [Listening/03_Tschuss_Nicos_Weg_transcript.md](Listening/03_Tschuss_Nicos_Weg_transcript.md) |

**All 3 Nicos Weg episodes now watched and comprehension-checked** (2026-09-08 through 2026-09-15). Consistent pattern across all three: strong plot/content tracking, with corrections landing on framing/detail-attribution rather than real German misunderstanding.

## Revision schedule

*Rebuilt 2026-09-19 — the previous version had every date in the past.
Dates here are derived from GRAMMAR.md's own next-revision column.*

| Topic | Status | Next check due |
|---|---|---|
| **Dative-only verbs** (helfen/danken/gehören) | LEARNING — regressed 09-17 | **2026-09-19 — overdue** |
| **Dative pronouns** (es→ihm / sie→ihr especially) | LEARNING — regressed 09-17 | **2026-09-19 — overdue** |
| **weil / verb-second in subordinate clauses** | LEARNING — 3 alternating failures | **2026-09-19 — overdue** |
| Perfekt — participle formation | LEARNING | 2026-09-19 |
| Perfekt — haben/sein selection | FUNCTIONAL | 2026-09-20 |
| nicht placement (definite objects) | FUNCTIONAL — slipped 09-18 | 2026-09-20 |
| Accusative case · dative prepositions · nach vs zu | FUNCTIONAL | 2026-09-22 |
| Two-way prepositions | FUNCTIONAL — 5/5 on 09-18 | 2026-09-25 |
| Accusative prepositions | FUNCTIONAL — 5/5 on 09-18 | 2026-09-25 |
| Imperative · yes/no questions · separable verbs | FUNCTIONAL | 2026-09-22 |
| Possessive articles | FUNCTIONAL | 2026-09-22 |
| Modal verbs · conjunctions · plurals · capitalization | FUNCTIONAL | 2026-09-25 |
| Vocabulary — all 13 themes (110 KNOWN) | KNOWN | rolling, every session per standing rule |

## Next action (detail)

**Where the comprehensive review stands (38/45 through Part 3):**

- **Part 1 — basics: 15/15.** sein/haben, accusative, yes/no questions,
  possessives, numbers, separable and modal verbs, irregular conjugations.
  Nothing to follow up.
- **Part 2 — dative: 10/15.** Surfaced the two active regressions below.
- **Part 3 — prepositions and word order: 13/15.** Two-way prepositions 5/5
  *with correct reasoning stated on every item*, closing out a topic that had
  needed four separate refreshers. Accusative prepositions 5/5, including
  *gegen unsere Eltern* with the "-en means plural" misconception explicitly
  disavowed unprompted — which is why it is finally treated as resolved rather
  than merely answered correctly.

**Immediately pending:** the nicht-placement drill (Q46–52), issued at the end
of 2026-09-18 but not attempted. Covers definite objects, indefinite objects,
modal + infinitive, separable verbs, adjectives, definite plurals.

**Then Part 4 onward** — the vocabulary sweep and the Perfekt material.

**Two active regressions, both narrow and well-characterised:**

1. **Dative-only verbs** (helfen/danken/gehören) — 3/3 on 09-10, then 1/3 on
   09-17. The verbs are *correctly identified* as dative-taking every time;
   the accusative pronoun gets reached for anyway (*danke ihn*, *gehört mich*).
   Drill the forms, not the concept.
2. **es → ihm versus sie → ihr** — three occurrences, always the same
   direction (*ihm* for both). Single slipperiest cell in the pronoun table.

**And one rule whose halves fail in alternation:** *weil* needs verb-last in
its own clause AND verb-second in the main clause. Three attempts, each with
exactly one half right (09-11 main clause, 09-15 and 09-18 the weil-clause).
Every isolated retest has been clean. **Practise both halves in one sentence** —
fixing them separately has demonstrably not worked.

**Note for when the future tense comes up:** the learner wrote *"ich will
morgen machen"* for "I'll do it tomorrow". *wollen* means "to want" — the
future is *werden* (Ich werde es morgen machen), still NOT_STARTED.

Standing method notes:
- **Reading is now a standing component of sessions, not an extra.** Two passages on
  2026-09-03 scored 7/8, making it immediately the learner's strongest modality —
  comprehension runs ahead of production, so reading exposes structures before they
  can be produced. Build passages from known vocabulary. Headroom exists: raise
  density, and consider seeding a few UNKNOWN words in context to practise inference
  from surrounding text.
- The stop-at-first-answer habit noted on the first passage did NOT recur on an
  un-telegraphed retest in the second. One instance each way — worth another probe,
  not yet a settled pattern either way.
- **Stop isolated conjugation drills.** The 3rd-person/du error has now failed 6
  times under load and passed 3 of 3 focused drills. Drilling it in isolation only
  re-confirms known material; embedding a 3rd-person subject in every mixed round
  is what actually tests it.
- **Voice mode is live** (2026-09-06). See VOICE_SETUP.md for the exact config.
  For conversation: `vad_aggressiveness: 0`, `listen_duration_min: 10`, silence
  detection ON. Use a fixed window (`disable_silence_detection`) only for
  multi-question `turns` surveys.
- **Voice cannot check endings.** STT outputs plausible German, so it repairs
  conjugation and article errors invisibly — this was demonstrated twice on
  2026-09-06 in both directions. Voice tests retrieval speed, fluency, word
  order and vocabulary reach. **Endings are checked in writing, always.**
  When a spoken reply looks phonetically garbled rather than grammatically
  wrong, ask for that sentence TYPED; re-asking reproduces the same mishearing.
- **Strict typing was requested by the learner** (2026-09-03) — umlauts,
  capitalization and spelling count as real errors, not typos to be waved through.

Worth reinforcing when the moment comes: the "a/any" vs "the" distinction is the
trigger for kein vs nicht, so article precision is not merely cosmetic for this
learner right now.

---

## Session history detail

### 2026-09-01 (Session 3, extended — longest and most productive session so far)

3-day-gap retest (5/5) → intensive review #1 of Lessons 1-4 (13.5/15, gap: formal
Ihr, now taught) → accusative case introduced and resolved (initial overgeneralization
→ 9/9 clean) → intensive review #2 of everything incl. accusative (12.5/15 clean + 2
soft notes) → conjugation drill (5/5, confirms slips are speed-related) →
possessives retest (3/3, → FUNCTIONAL) → family vocabulary (6 words) → numbers 1-20
→ food vocabulary (7 words/verbs) → modal verbs introduced (können, 2/4 then 2/2
clean retry). Accusative case, possessives, and Lessons 1-3 all promoted to
FUNCTIONAL. Learner also asked about A2 timeline — see project_a2_timeline_estimate
memory (rough estimate: 3-6 months at current pace, to be revisited periodically).

Full detail: [daily_notes/2026-09-01.md](daily_notes/2026-09-01.md)

### 2026-09-02 (Session 4, extended — very long, high-energy day)

Fresh-day retest caught 2 genuine retention gaps (verb-second beyond questions,
mein/meine gender agreement) — both re-taught and drilled extensively (10-11 clean
same-day instances). Extended modal verbs to müssen/möchten. Added ~21 vocabulary
words across daily routine/time, weather, and shopping themes. Answered 5 learner
questions (Q6-Q10) on accusative-taking verbs, modal verbs and accusative, and
kein-vs-nicht mechanics in depth.

Full detail: [daily_notes/2026-09-02.md](daily_notes/2026-09-02.md)

### 2026-09-03 (Session 5)

Genuine overnight retest confirmed both 2026-09-02 watch-items are now solid:
verb-second held 4/4 (including after "so"), mein/meine gender agreement held 4/4.
Both promoted to FUNCTIONAL.

Continued the same day with house & rooms vocabulary (7 words), chosen by the
learner over new grammar. Set was built to double as accusative/gender practice —
all grammar under test held clean (4/5, 2/3, then 2/2 on a targeted check). Two
surface slips, both corrected on retry: an invented umlaut (Stühl for Stuhl, now a
tracked 3-instance pattern) and a definite-for-indefinite article slip. Compound
nouns introduced in passing and applied correctly first try. The old "zweinen
Hunde" error from 2026-09-01 confirmed resolved.

Part three: accusative pronouns introduced (mich/dich/ihn/uns/euch), taught by
parallel to the already-FUNCTIONAL der→den pattern (er→ihn changes; sie/es don't),
which cut the new material to five forms and was absorbed immediately. Intro set
4/5, focused drill 4/4. Every pronoun form correct throughout; the one bad sentence
carried a conjugation slip and a nicht-placement slip around a correct pronoun. Key
finding: the 3rd-person/du conjugation error is confirmed load-dependent (6 failures
all under load, 3 focused drills all clean) — isolated drilling retired in favour of
embedding 3rd-person subjects in mixed rounds.

Part four: mixed consolidation round, no new material (a fourth new topic was
deliberately declined). 4/5, with four 3rd-person subjects all correct while
carrying new pronouns, new vocabulary, accusative, verb-second and possessives at
once — the first time this conjugation has held under genuine load on record. Only
error was an omitted umlaut (konnen), logged separately from the invented-umlaut
pattern since the two have opposite causes.

Part five: first reading practice in five sessions, filling a documented gap
("Reading: Not yet practiced"). A ~9-sentence passage of known vocabulary, 3/4
comprehension questions fully correct. Parsed denn causality, a separable verb,
kein/keine and modal+infinitive without difficulty — all structures that still cause
production errors. Comprehension is ahead of production, so reading is an
under-used lever worth adding to the regular rotation.

Part six: a second, denser passage run immediately to test the stop-at-first-answer
habit — un-telegraphed. 4/4. The learner gave both halves of a split answer and
linked them causally where the text supplied no connector, and inferred unmarked
causality. The habit did not recur. (NOTE: the es → das Haus resolution originally
credited here as gender tracking was probably right for the wrong reason — see
part seven.)

Part seven: third passage, four unknown words seeded — all four inferred correctly,
including the non-cognate groß from an "acht Zimmer" anchor. But the passage exposed
the day's most important finding: the learner selects accusative pronouns by ENGLISH
semantics (thing→es, person→ihn) rather than German grammatical gender, swapping
es/ihn exactly on a follow-up check. This also revealed a flaw in the morning's
exercise design — every pronoun prompt named the pronoun in English, so 9/9 tested
form recall while never once testing selection. Rule taught, drill 4/4 across all
three genders, but same-round only.

Full detail: [daily_notes/2026-09-03.md](daily_notes/2026-09-03.md)

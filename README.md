# 🇩🇪 German Learning — Zero to B2

Personal long-term German learning system, guided by a persistent AI tutor (Claude Code).
Goal: rebuild German from the foundations and reach **functional B2** — with long-term
retention prioritized over speed.

**Started:** 2026-08-28

## How it works

The conversation is never the memory — **these files are**. Every study session begins by
reading the persistent state and continues exactly where the last one stopped, even months
later or on a different machine. Every session ends by updating the files and pushing.

To resume at any time, open a Claude Code session in this workspace and say **"continue"**.

## Repository structure

```
german_learning/
├── CURRENT_STATE.md          # Read FIRST each session — level, topic, weaknesses, exact NEXT ACTION
├── Complete Notes.md         # THE STUDY DOCUMENT — everything covered, written to revise from
├── Complete Notes.pdf        # Generated from the above by build_notes.sh (with .tex)
├── MASTER_PROGRESS.md        # Long-arc view: CEFR level, skills, weak areas, assessments
├── VOCABULARY.md             # Persistent vocab database (article, plural, examples, review status)
├── GRAMMAR.md                # Grammar topics with status: NOT_STARTED → ... → MASTERED (table per CEFR level)
├── ERROR_LOG.md              # Recurring mistakes — automatically become revision material
├── SESSION_LOG.md            # Per-session record, newest first
├── DOUBTS.md                 # Drop a question here anytime — gets answered and filed to ANSWERS.md
├── ANSWERS.md                # Answered questions, moved here from DOUBTS.md (dated, newest last)
├── STUDY_PLAN.md             # Daily/weekly structure — 3 hrs/day from 2026-09-07, block by block
├── VOCAB_PLAN.md             # Cross-references VOCABULARY.md against the Anki deck below;
│                              # tracks coverage and prioritizes what to teach next
├── PRONOUN_TABLE.md          # Reference: nominative / accusative / dative pronouns + possessive endings
├── VOICE_PROMPT.md           # Context prompt to paste into Claude app voice mode for speaking practice
├── ANKI_A1_A2_REFERENCE.md   # Plain-text export of a 1367-word Anki A1/A2 deck, for planning
├── build_notes.sh            # Rebuilds Complete Notes.tex/.pdf from the Markdown (pandoc + xelatex)
├── Listening/                 # Nicos Weg episodes + locally-generated transcripts
├── archive/                   # Resolved errors and older sessions — not read at session start
└── daily_notes/               # One file per study date (YYYY-MM-DD.md) — everything covered that day
```

Two Anki `.apkg` deck files also live in `german_learning/` locally but are
gitignored (one exceeds GitHub's 100MB file limit) — not backed up to GitHub.

## Method

- **Learn → Practice → Recall → Use → Review → Test → Revisit** — never lecture-only
- **Spaced repetition:** material resurfaces at ~1 / 3 / 7 / 14 / 30 days, adjusted by performance
- **Active recall over passive reading** — the tutor asks before it tells
- **Error-driven:** repeated mistakes are tracked and drilled until resolved
- **Completion ≠ mastery:** topics are only MASTERED after correct spontaneous use across sessions

## Roadmap

| Level | Focus |
|---|---|
| Foundation | Pronunciation, greetings, sein/haben, articles, basic sentences |
| A1 | Present tense, cases (Nom/Akk), modal verbs, everyday vocabulary |
| A2 | Perfekt, dative, subordinate clauses, adjective endings |
| B1 | Passive, Konjunktiv II, relative clauses, opinions & argumentation |
| B2 | Advanced grammar consolidation, idiomatic & professional German |

## Current status

📍 **PRE-A1 / Foundation moving into A2, 15 sessions in.** Diagnostic confirmed
a true-beginner restart. FUNCTIONAL (retested across real gaps): sein/haben,
articles, negation (nicht and kein, incl. placement), accusative case and
pronouns, possessive articles (incl. formal Ihr), plurals, W-questions and
yes/no questions, conjunctions, modal verbs, separable verbs, the imperative
(du/ihr/Sie), dative prepositions and the nach-vs-zu rule — plus, at A2, the
haben/sein choice in the Perfekt.

Currently LEARNING: Perfekt participle formation, two-way prepositions, dative
pronouns and dative-only verbs, verb-second in subordinate clauses.
Vocabulary: 142 entries, 110 confirmed through production, across 13 themes.
Reading remains the strongest modality; listening (Nicos Weg A1) and speaking
(voice mode) have both been active since early September.

Study time increased to **~3 hours/day from 2026-09-07** — see STUDY_PLAN.md.
The added hours go to depth per concept, not more concepts: a hard cap of two
new grammar points per week, with the rest spent on retrieval, mixed practice,
daily free writing, and the newly added listening and speaking work. See
[german_learning/CURRENT_STATE.md](german_learning/CURRENT_STATE.md) for the exact
next action, and [german_learning/VOCAB_PLAN.md](german_learning/VOCAB_PLAN.md)
for the vocabulary roadmap.

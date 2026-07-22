# Evidence-First Paper Writing

> An evidence-first orchestration skill for scientific paper writing.

`evidence-first-paper-writing` is a portable orchestration Skill for research planning, literature work, drafting, scientific translation, pre-submission checks, and revision. It is not a paper generator and does not claim to replace specialised Skills.

Its rule is simple:

> No results, no results section. No verification, no conclusion. Missing material stays explicitly missing.

## What it does

- Identifies the current research stage and checks its entry conditions.
- Separates verified facts, author hypotheses, planned work, and missing evidence.
- Routes a task to an optional specialised Skill when that Skill is available.
- Stops unsupported drafting instead of inventing data, citations, experiments, approvals, or conclusions.
- Preserves claim strength during translation, polishing, and style editing.

The stage gates are:

| Stage | Required before progressing | Not allowed yet |
|---|---|---|
| Scope | A researchable question, object, and boundary | A complete abstract or findings |
| Evidence | Traceable sources and a claim ledger | Unsupported literature claims |
| Design | Data/source plan, comparison, metric, and analysis plan | Predicted results |
| Draft | Confirmed evidence and section contract | Hidden limitations |
| Language | Facts, terms, numbers, and citations locked | Stronger claims or new causality |
| Quality assurance | Manuscript, figures, citations, and disclosures checked | Treating open items as complete |
| Revision | Reviewer-comment-to-change mapping | Unverified response claims |

## Contents

```text
evidence-first-paper-writing/
├── SKILL.md
├── agents/openai.yaml
└── references/
    ├── research-foundation-template.md
    ├── drafting-and-integrity-checklist.md
    ├── academic-translation-and-style.md
    ├── skill-routing.md
    ├── dependency-and-license-register.md
    └── example-scenarios.md
```

## Install

Clone or download this repository, then copy the complete `evidence-first-paper-writing/` directory into the target agent's Skill directory. Do not copy `SKILL.md` alone: the workflow links to its reference files.

For a local checkout, the included installer supports these targets:

```bash
./install.sh --codex
./install.sh --claude
./install.sh --workbuddy
./install.sh --target /path/to/skills
```

The installer refuses to overwrite an existing Skill directory.

## Optional dependency Skills

The workflow can route to specialised Skills, but **does not bundle, install, copy, or relicense them**. Install each one separately from its original source and follow its own licence and attribution conditions.

- `academic-research-suite`: research framing, research design, and integrity review.
- `researchwrite`: evidence tables, argument maps, and section contracts.
- `nature-*`: literature discovery, reading, citation checking, drafting, figures, data disclosure, review, response, presentation, and patent-oriented assessment.
- `humanizer`: language-only cleanup after scientific facts are confirmed.

The complete registry, including redistribution decisions and licence status, is in [dependency-and-license-register.md](evidence-first-paper-writing/references/dependency-and-license-register.md).

## Generic example

```text
Use evidence-first-paper-writing.

I am investigating whether changes in street-tree canopy are associated with summer surface-temperature patterns in a fictional regional dataset. I have incomplete satellite images and a preliminary list of weather records, but no cleaned dataset, statistical analysis, or verified literature set.

Return the current stage, missing materials, prohibited outputs, and the next tasks. Do not draft results, invent statistics, or turn an association into causation.
```

Expected outcome: the Skill remains in scope/evidence/design preparation, asks for variable definitions, quality-control rules, covariates, analysis plan, and verified sources, and blocks causal or result-level claims.

Additional fully fictional test scenarios are in [example-scenarios.md](evidence-first-paper-writing/references/example-scenarios.md).

## Privacy and publication boundary

This repository contains only generic workflow instructions and fictional examples. Do not add unpublished manuscripts, datasets, reviewer correspondence, author details, institutional material, private templates, research topics, or other identifying information.

## Licence

The original files in this repository are available under the [MIT License](LICENSE). That licence does not apply to any optional upstream dependency. See the dependency register before copying or redistributing external Skill content.

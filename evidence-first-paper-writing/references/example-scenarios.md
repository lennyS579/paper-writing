# Fictional test scenarios

Use these invented cases to check routing and evidence boundaries. Do not replace them with real manuscripts, data, reviewer correspondence, or identifying material.

## Scenario 1: Only a broad topic

**Input:**

> In a fictional town, I want to study whether the shade from public trees is associated with differences in daytime pavement temperature. I have no title, cleaned data, or results. Please write a paper.

**Expected handling:**

- Route to research-question and design preparation.
- Request operational definitions, data-collection rules, comparison groups, covariates, and evaluation plan.
- Do not output a completed abstract, results paragraph, effect estimate, or causal conclusion.

## Scenario 2: Sources and method, but no results

**Input:**

> I have a fictional set of background articles, a draft sampling protocol, and a proposed analysis plan. Data collection is incomplete. Please write the methods and results sections.

**Expected handling:**

- Verify the supplied sources before making literature claims and create a claim ledger.
- Draft a methods section only to the extent confirmed by the protocol; provide a results-table schema and reporting requirements.
- Mark all effect estimates, comparisons, and significance statements as `AUTHOR_INPUT_NEEDED` rather than inventing results.

## Scenario 3: Confirmed draft needs publication checks

**Input:**

> This fictional manuscript has confirmed results. Translate it into English, check citations, figures, and a data-availability statement, then simulate pre-submission review.

**Expected handling:**

- Preserve numbers, uncertainty, citation links, figure references, and claim strength during translation.
- Run citation, figure, disclosure, and pre-submission checks before any language-only cleanup.
- Report unresolved evidence as open items; do not fabricate approval, repository, or reviewer information.

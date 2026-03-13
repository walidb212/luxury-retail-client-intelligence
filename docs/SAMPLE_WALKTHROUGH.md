# Sample Walkthrough

## Input

See [`examples/sample_notes.csv`](../examples/sample_notes.csv).

Example note:

> Client interested in a structured black leather handbag for work travel. Budget around 4500 EUR. Birthday gift for partner next month. Follow up next week.

## Pipeline Interpretation

- Router: likely Tier 1 or Tier 2 depending on note detail and ambiguity
- Product pillar: handbag, black, leather, work / travel usage
- Client pillar: gift intent, premium potential, partner-related context
- Hospitality pillar: birthday occasion
- Business pillar: budget, follow-up timing, recommendation candidate

## Output

See [`examples/sample_output.json`](../examples/sample_output.json).

The sample output shows:

- normalized routing metadata
- structured 4-pillar extraction
- product suggestions
- a Next Best Action
- basic quality and privacy signals

## Preview Asset

See [`examples/app-preview.svg`](../examples/app-preview.svg) for the lightweight public preview used in this repo.

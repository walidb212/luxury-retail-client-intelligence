# Luxury Retail Client Intelligence

FastAPI + React project that transforms client advisor notes into structured CRM intelligence for luxury retail teams.

This public repository is a portfolio-safe snapshot of a larger internal-style system. It keeps the product, pipeline, and engineering decisions visible without exposing private datasets, production URLs, or internal documentation.

## What This Project Does

- ingests free-form advisor notes from API or UI
- cleans and normalizes multilingual text
- masks sensitive information before provider-backed processing
- routes each note to an appropriate extraction tier
- structures output into a 4-pillar CRM schema
- enriches results with product matching and recommendation logic
- exposes advisor, manager, and admin workflows in a React frontend

## Capability Snapshot

### NLP and Extraction

- multilingual note cleaning with filler removal and privacy masking
- deterministic Tier 1 rules for simple notes
- optional LangExtract-based extraction path
- optional Mistral-backed extraction for richer notes
- 4-pillar structured outputs with routing and quality metadata

### CRM Intelligence

- product universe extraction
- client profile enrichment
- hospitality and occasion signals
- Next Best Action generation
- quality scoring and manager-facing review flows

### Platform

- FastAPI backend with health endpoints and middleware
- React 18 frontend with advisor / manager / admin views
- JWT-based authentication and role checks
- optional WebSocket pipeline visualization
- optional GraphQL endpoint when `strawberry-graphql` is installed

## 4-Pillar Schema

| Pillar | Purpose | Example Signals |
| --- | --- | --- |
| Product Universe | Capture what the client is interested in | category, model, color, material, matched products |
| Client Profile | Describe who the client is and how they shop | VIP status, purchase context, lifestyle, profession |
| Hospitality / Care | Capture service and relationship context | occasion, dietary notes, allergies, preferences |
| Business Action | Turn signals into operational follow-up | budget, urgency, lead temperature, Next Best Action |

Representative examples live in [`examples/sample_notes.csv`](examples/sample_notes.csv) and [`examples/sample_output.json`](examples/sample_output.json).

## Architecture at a Glance

1. a note enters via the API or frontend
2. text cleaning normalizes the input and masks PII
3. the router selects a low-cost deterministic or provider-backed path
4. extraction produces a structured 4-pillar payload
5. optional product matching enriches the result
6. optional recommendation logic proposes a Next Best Action
7. results are stored and rendered in the frontend

High-level architecture details are documented in [`docs/ARCHITECTURE.md`](docs/ARCHITECTURE.md).

## Public Snapshot Contents

- backend API and pipeline code
- frontend application with role-based views
- minimal public docs
- clean sample input / output assets
- default install path that works without provider keys
- optional advanced dependency set in [`requirements.optional.txt`](requirements.optional.txt)

## Stack

| Area | Technologies |
| --- | --- |
| Backend | FastAPI, SQLAlchemy, Pydantic |
| Frontend | React 18, Vite, TailwindCSS |
| NLP / LLM | rule-based extraction, LangExtract hooks, Mistral hooks, OpenAI fallback hooks |
| Retrieval | sentence-transformers hooks, local ZVec-compatible matcher, vector search entry points |
| Storage | SQLite by default |
| Auth | JWT + password hashing |

## Quick Start

Backend:

```bash
pip install -r requirements.txt
python -m uvicorn api.main:app --reload --port 8000
```

Optional advanced features:

```bash
pip install -r requirements.optional.txt
```

Frontend:

```bash
cd frontend-v2
npm install
npm run dev
```

Frontend build:

```bash
cd frontend-v2
npm run build
```

Default local URLs:

- frontend: `http://localhost:5173`
- API docs: `http://localhost:8000/docs`

## Demo Accounts

Local demo accounts can be auto-seeded when `ALLOW_DEMO_ACCOUNTS=true`:

- `advisor@example.com`
- `manager@example.com`
- `admin@example.com`

The default local password is controlled by `DEMO_PASSWORD` in [`.env.example`](.env.example).

## Environment

Copy [`.env.example`](.env.example) to `.env` and fill only what you need.

Important public variables:

- `APP_NAME`
- `DEMO_PASSWORD`
- `ALLOW_DEMO_ACCOUNTS`
- `USE_ZVEC`
- `ENABLE_NBA_LLM`
- `ENABLE_RAG_QUERY_LLM`
- `OPENAI_API_KEY`
- `MISTRAL_API_KEY`

The default public path is intentionally lightweight:

- the API can start without provider keys
- the core install path does not require an external `zvec` package
- advanced provider-backed features live behind optional dependencies and env flags

## Security and Privacy

- PII masking is applied before provider-backed processing
- sensitive-data filters and RGPD-style flags are part of the pipeline
- JWT-based auth protects role-specific routes
- demo credentials are generic and public-safe
- no real production secrets, deployment URLs, or internal datasets are included in this snapshot

## Validation Path

The repo was prepared so the default path is straightforward to verify:

```bash
pip install -r requirements.txt
python -c "import api.main; print('OK')"
pytest tests/test_text_cleaner.py -q
cd frontend-v2 && npm run build
```

If `strawberry-graphql` is not installed, the GraphQL endpoint is disabled with a warning, but the API still starts normally.

## Tests

Fast default path:

```bash
pytest tests/test_text_cleaner.py -q
```

Optional integration path:

```bash
set RUN_INTEGRATION_TESTS=1
pytest tests/test_precision.py tests/test_production.py -q
```

## Repo Layout

- [`api`](api): FastAPI routes, auth, middleware, database wiring
- [`src`](src): pipeline, routing, extraction, recommendation, retrieval
- [`frontend-v2/src`](frontend-v2/src): React application
- [`examples`](examples): public sample note, output, and preview asset

## Boundaries

- this is a public portfolio snapshot, not a full production export
- internal datasets, generated reports, local databases, and operational docs were intentionally removed
- no public live deployment is advertised from this repo
- some advanced flows require provider keys or a rebuilt local product index

For a concrete example of the pipeline output, see [`docs/SAMPLE_WALKTHROUGH.md`](docs/SAMPLE_WALKTHROUGH.md).

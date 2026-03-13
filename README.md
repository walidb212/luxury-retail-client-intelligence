# Luxury Retail Client Intelligence

An end-to-end FastAPI + React project that turns client advisor notes into structured CRM signals for luxury retail teams.

This public version is intentionally compact. It keeps the core ideas visible:

- multilingual note cleaning and routing
- 4-pillar structured extraction
- product matching / RAG hooks
- Next Best Action generation
- role-based frontend views for advisor, manager, and admin flows

## Stack

- Backend: FastAPI, SQLAlchemy, Pydantic
- Frontend: React 18, Vite, TailwindCSS
- LLM / NLP: Mistral, OpenAI fallback, LangExtract, rule-based extraction
- Retrieval: sentence-transformers, vector matching hooks
- Storage: SQLite by default

## What Is Included

- core backend and frontend code
- runnable unit tests
- optional integration tests gated behind env vars
- clean sample input/output in [`examples/sample_notes.csv`](examples/sample_notes.csv) and [`examples/sample_output.json`](examples/sample_output.json)
- a lightweight UI preview in [`examples/app-preview.svg`](examples/app-preview.svg)

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

Default app URLs:

- Frontend: `http://localhost:5173`
- API docs: `http://localhost:8000/docs`

## Environment

Copy [`.env.example`](.env.example) to `.env` and fill what you need.

Most provider-backed features are optional. The repo is designed so that:

- the app can start without provider keys
- unit tests can run without provider keys
- integration tests only run when explicitly enabled
- advanced provider-backed features can be added with `requirements.optional.txt`

Key public env vars:

- `APP_NAME`
- `DEMO_PASSWORD`
- `USE_ZVEC`
- `ENABLE_NBA_LLM`
- `ENABLE_RAG_QUERY_LLM`
- `OPENAI_API_KEY`
- `MISTRAL_API_KEY`

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

- [`api`](api): FastAPI routes, auth, database wiring
- [`src`](src): pipeline, routing, extraction, recommendation, retrieval
- [`frontend-v2/src`](frontend-v2/src): React application
- [`examples`](examples): sample note, sample output, public preview asset

## Notes

- This repo is a public portfolio snapshot, not a full internal production export.
- Real deployment URLs, internal datasets, generated outputs, local databases, and internal docs were intentionally removed.
- Some advanced flows depend on external provider keys or a rebuilt product index.
- The default install path does not require an external `zvec` package; the repo includes a local compatible matcher.

Additional context lives in:

- [`docs/ARCHITECTURE.md`](docs/ARCHITECTURE.md)
- [`docs/SAMPLE_WALKTHROUGH.md`](docs/SAMPLE_WALKTHROUGH.md)

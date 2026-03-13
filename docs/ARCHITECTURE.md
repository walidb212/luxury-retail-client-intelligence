# Architecture

## Overview

The system processes advisor notes through a layered pipeline:

1. input note arrives through API or UI
2. text cleaning normalizes content and masks sensitive data
3. router selects the cheapest acceptable extraction tier
4. extraction produces a 4-pillar structured payload
5. optional product matching enriches the result
6. optional recommendation logic generates a Next Best Action
7. the API stores results and the frontend renders advisor / manager / admin views

## Main Components

- `api/main.py`: FastAPI app, middleware, health endpoints, CORS, router registration
- `api/routers/`: auth, analysis, results, stats, dashboard, batch processing
- `src/pipeline_async.py`: orchestration across cleaning, routing, extraction, retrieval, and recommendation
- `src/smart_router.py`: heuristic routing between deterministic and LLM-backed tiers
- `src/tier1_rules.py`: fast deterministic extraction for simple notes
- `src/tier2_langextract.py` and `src/tier2_mistral.py`: provider-backed extraction paths
- `src/extractor.py`: premium extraction path for complex notes
- `src/product_matcher.py`: product matching / RAG entry point
- `src/recommender.py`: Next Best Action generation
- `frontend-v2/src/components/`: advisor, manager, admin, taxonomy, and debug views

## Data Flow

- Input shape: free-form client advisor note, optionally with language and metadata
- Core output shape:
  - routing metadata
  - RGPD / sensitive-data flags
  - 4 structured pillars
  - matched products
  - Next Best Action
  - quality metadata

The 4 pillars are:

1. product universe
2. client profile
3. hospitality / care
4. business action

## Runtime Expectations

- SQLite is the default local database
- provider-backed extraction needs `MISTRAL_API_KEY` and optionally `OPENAI_API_KEY`
- vector matching may need a rebuilt index depending on your setup
- the backend can start without provider keys, but some extraction routes are limited in that mode

## Public Snapshot Boundaries

- internal datasets, generated reports, live deployment URLs, and internal operations docs are intentionally excluded
- demo accounts use `example.com` addresses
- integration tests are opt-in

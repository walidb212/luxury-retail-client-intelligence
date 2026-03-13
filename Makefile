.PHONY: install backend frontend test clean docker-build docker-up docker-down docker-logs

install:
	pip install -r requirements.txt

backend:
	python -m uvicorn api.main:app --reload --port 8000

frontend:
	cd frontend-v2 && npm run dev

test:
	pytest tests/test_text_cleaner.py -q

lint:
	flake8 src/ api/ tests/ --max-line-length=120

clean:
	rm -rf .pytest_cache frontend-v2/dist

docker-build:
	docker build -t luxury-retail-voice-crm .

docker-up:
	docker-compose up -d

docker-down:
	docker-compose down

docker-logs:
	docker-compose logs -f

.PHONY: uv
uv:
	@command -v uv >/dev/null 2>&1 || curl -LsSf https://astral.sh/uv/install.sh | sh

.PHONY: dev
dev: uv
	uv sync --dev

.PHONY: lock
lock: uv
	uv lock

.PHONY: install
install: uv
	uv sync --frozen

.PHONY: run
run: uv
	uv run python manage.py runserver

.PHONY: migrate
migrate: uv
	uv run python manage.py migrate

.PHONY: test
test: uv
	uv run pytest

.PHONY: lint
lint: uv
	uv run ruff check ./core ./main_app ./tests

.PHONY: fix
fix: uv
	uv run ruff check ./core ./main_app ./tests --fix
	uv run ruff format ./core ./main_app ./tests

.PHONY: cov
cov: uv
	uv run pytest --cov=core --cov-report=term-missing
	uv run pytest --cov=main_app --cov-report=term-missing

.PHONY: doc
doc: uv
	cd docs && uv run make html

.PHONY: build
build: uv
	uv build

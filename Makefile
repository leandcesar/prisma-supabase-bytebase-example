VENV = venv
PYTHON = $(VENV)/bin/python3
PIP = $(VENV)/bin/pip

.PHONY: install run test lint clean
.DEFAULT_GOAL = help

$(VENV)/bin/activate: requirements.txt
	python3 -m venv $(VENV)
	$(PIP) install -U pip
	$(PIP) install -r requirements.txt

install: $(VENV)/bin/activate

uninstall:
	rm -rf $(VENV)

version:
	$(PYTHON) --version
	$(PIP) --version
	$(PIP) freeze

run: $(VENV)/bin/activate
	. venv/bin/activate && python main.py

test: $(VENV)/bin/activate
	. venv/bin/activate && pytest .

lint: $(VENV)/bin/activate
	. venv/bin/activate && ruff check .

format: $(VENV)/bin/activate
	. venv/bin/activate && black .

clean:
	@rm -rf .cache
	@rm -rf .pytest_cache
	@rm -rf *.egg-info
	@rm -rf .coverage
	@rm -rf coverage.xml
	@$(PYTHON) -Bc "for p in __import__('pathlib').Path('.').rglob('*.py[co]'): p.unlink()"
	@$(PYTHON) -Bc "for p in __import__('pathlib').Path('.').rglob('__pycache__'): p.rmdir()"

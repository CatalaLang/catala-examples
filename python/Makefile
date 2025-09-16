SOURCES = main.py src/api.py

type:
	mypy $(SOURCES)

format:
	autopep8 --in-place $(SOURCES)

bench:
	python main.py bench_family
	python main.py bench_housing

show_log:
	python main.py show_log

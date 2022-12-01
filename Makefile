.PHONY: lint format

lint:
	swiftlint

format:
	swiftlint autocorrect

.PHONY: test lint format

test:
	swift test

lint:
	swiftlint

format:
	swiftlint autocorrect

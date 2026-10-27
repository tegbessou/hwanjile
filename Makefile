.PHONY: install unit-test integration-test format-check format-fix clippy architecture deps-check quality

## Tools
NIGHTLY = nightly-2026-01-22

install:
	rustup install
	rustup toolchain install $(NIGHTLY) --profile minimal --component rust-src,rustc-dev,llvm-tools-preview
	cargo +$(NIGHTLY) install --locked cargo_pup@0.1.8
	cargo install --locked cargo-deny@0.20.2 cargo-machete@0.9.2

## Tests
unit-test:
	cargo test --lib --bins

integration-test:
	cargo test --test '*'

## Quality
format-check:
	cargo fmt --all --check

format-fix:
	cargo fmt --all

clippy:
	cargo clippy --all-targets -- -D warnings

architecture:
	cargo +$(NIGHTLY) pup --ignore-rust-version

deps-check:
	cargo deny check
	cargo machete

quality: format-check clippy architecture deps-check

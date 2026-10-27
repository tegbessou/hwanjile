.PHONY: install unit-test integration-test format-check format-fix clippy public-api deps-check quality

## Tools
NIGHTLY = nightly-2026-10-25
DOMAIN_PORTS = DealRepository|Shuffler|DealerDraw

install:
	rustup install
	rustup toolchain install $(NIGHTLY) --profile minimal
	cargo install --locked cargo-deny@0.20.2 cargo-machete@0.9.2 cargo-public-api@0.52.0

## Tests
unit-test:
	cargo test --workspace --lib --bins

integration-test:
	cargo test --workspace --test '*'

## Quality
format-check:
	cargo fmt --all --check

format-fix:
	cargo fmt --all

clippy:
	cargo clippy --workspace --all-targets -- -D warnings

public-api:
	@api=$$(cargo +$(NIGHTLY) public-api --package hwanjile-application) || exit 1; \
	if echo "$$api" | sed -E '/^(pub struct|impl<)/ s/([:+] )hwanjile_domain::([a-z_]+::)*($(DOMAIN_PORTS))([,> +]|$$)/\1\4/g' | grep hwanjile_domain; then \
		echo "hwanjile-application expose un type du domaine (ADR-0005, ADR-0007)"; \
		exit 1; \
	fi
	@if grep --recursive --line-number "pub use " crates/hwanjile-application/src; then \
		echo "hwanjile-application réexporte un élément (ADR-0007)"; \
		exit 1; \
	fi

deps-check:
	cargo deny check
	cargo machete

quality: format-check clippy public-api deps-check

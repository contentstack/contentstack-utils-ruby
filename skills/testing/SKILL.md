---
name: testing
description: Use when writing or fixing RSpec tests, mocks, fixtures, SimpleCov filters, or WebMock usage in this repo.
---

# Testing – Contentstack Utils Ruby

## When to use

- Adding coverage for a new code path in `lib/`
- Debugging a failing spec in `spec/`
- Adjusting SimpleCov scope or shared test helpers

## Instructions

### Runner and config

- **RSpec** is the test framework; **`spec/spec_helper.rb`** loads SimpleCov, then `contentstack_utils`, mocks, and support files
- **Default task:** `bundle exec rake` runs **`spec`** with `--format documentation` (see `Rakefile`)

### Layout

- **`spec/lib/`** — primary examples (`utils_spec.rb`, `model/option_spec.rb`, `model/metadata_spec.rb`)
- **`spec/mock/`** — constants and custom option subclasses used across examples
- **`spec/support/`** — helpers (e.g. XML/JSON fixture builders like `getGQLJSONRTE`)

### Coverage

- **SimpleCov** starts in `spec_helper.rb` and **filters** `spec/` and `lib/contentstack_utils/support` from coverage metrics
- Aim to cover both **HTML `render_content`** paths and **JSON / GQL `json_to_html`** branches when changing `utils.rb`

### HTTP and external I/O

- **webmock** is a development dependency; stub outbound HTTP if future tests introduce network calls (current suite is largely pure parsing/rendering)

### Credentials

- Do not add real API keys, delivery tokens, or stack secrets to the repo; use fixture hashes and constants as in `spec/mock/` and `spec/support/constant.rb`

## References

- [Development workflow](../dev-workflow/SKILL.md)
- [Contentstack Utils SDK](../contentstack-utils/SKILL.md)
- [RSpec](https://rspec.info/)
- [SimpleCov](https://github.com/simplecov-ruby/simplecov)

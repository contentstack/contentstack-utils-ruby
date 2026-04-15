# Contentstack Utils Ruby – Agent guide

**Universal entry point** for contributors and AI agents. Detailed conventions live in **`skills/*/SKILL.md`**.

## What this repo is

| Field | Detail |
|--------|--------|
| **Name:** | [contentstack/contentstack-utils-ruby](https://github.com/contentstack/contentstack-utils-ruby) |
| **Purpose:** | Ruby gem that renders Contentstack rich text and JSON RTE (including GraphQL-shaped payloads) to HTML, with pluggable rendering via `ContentstackUtils::Model::Options` subclasses. |
| **Out of scope (if any):** | This package does not ship an HTTP client or stack SDK; it pairs with the separate Contentstack Ruby delivery client for entry data and `_embedded_items`. |

## Tech stack (at a glance)

| Area | Details |
|------|---------|
| Language | Ruby **≥ 3.1** (see `contentstack_utils.gemspec` and `.ruby-version` for local dev) |
| Build | **Bundler** + **RubyGems**; `contentstack_utils.gemspec`, `Gemfile` |
| Tests | **RSpec**; specs under `spec/**/*_spec.rb`, loaded via `spec/spec_helper.rb` |
| Lint / coverage | No RuboCop in-repo; **SimpleCov** in `spec/spec_helper.rb`; API docs via **YARD** (`.yardopts`, `rake yard`) |
| Runtime deps | **activesupport** (7.x), **nokogiri** (HTML / XML for legacy RTE strings) |

## Commands (quick reference)

| Command type | Command |
|--------------|---------|
| Install deps | `bundle install` |
| Build (default task) | `bundle exec rake` (runs **spec**) |
| Test | `bundle exec rake spec` or `bundle exec rspec` |
| Docs | `bundle exec rake yard` |

**CI / automation:** There is no dedicated workflow that runs `rspec` on every push; local verification is `bundle exec rake`. Other workflows include branch checks (PRs into `master`), release publish, CodeQL, policy/SCA scans—see `.github/workflows/`.

## Where the documentation lives: skills

| Skill | Path | What it covers |
|-------|------|----------------|
| Code review | `skills/code-review/SKILL.md` | PR checklist for this gem |
| Contentstack Utils SDK | `skills/contentstack-utils/SKILL.md` | Public API, models, CDA vs GQL paths, versioning |
| Development workflow | `skills/dev-workflow/SKILL.md` | Branches, Bundler/Rake, gem build, workflows |
| Framework & packaging | `skills/framework/SKILL.md` | Gemspec, dependencies, Ruby version, release |
| Ruby style and layout | `skills/ruby-style/SKILL.md` | Module layout, naming, matching existing code |
| Testing | `skills/testing/SKILL.md` | RSpec layout, mocks, SimpleCov, WebMock |

An index with “when to use” hints is in `skills/README.md`.

## Using Cursor (optional)

If you use **Cursor**, **`.cursor/rules/README.md`** is the only file under `.cursor/rules`; it points to **`AGENTS.md`**—same docs as everyone else.

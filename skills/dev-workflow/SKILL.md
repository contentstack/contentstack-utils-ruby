---
name: dev-workflow
description: Use when setting up the dev environment, running build/test/docs, or understanding CI, branches, and gem release for this repo.
---

# Development workflow – Contentstack Utils Ruby

## When to use

- Cloning the repo or onboarding a new contributor
- Running tests, generating docs, or building the gem locally
- Understanding branch rules and GitHub Actions for this repository

## Instructions

### Prerequisites

- Ruby **≥ 3.1** (matches `s.required_ruby_version` in `contentstack_utils.gemspec`)
- Bundler; install gems with `bundle install`

### Everyday commands

- **Run tests (default Rake task):** `bundle exec rake` or `bundle exec rake spec`
- **RSpec directly:** `bundle exec rspec` (pattern `spec/**/*_spec.rb` is configured in `Rakefile`)
- **YARD API docs:** `bundle exec rake yard` (see `.yardopts` for included paths)
- **Build gem artifact:** `gem build contentstack_utils.gemspec` (also used in `.github/workflows/release-gem.yml`)

### Version and changelog

- Gem version lives in `lib/contentstack_utils/version.rb` as `ContentstackUtils::VERSION`
- Document user-visible changes in `CHANGELOG.md` when releasing

### Branches and PRs

- Feature/fix PRs should target **`development`**. Release PRs are raised directly from **`development`** to **`master`**.
- Use `CODEOWNERS` for required reviewers when applicable

### CI and automation (no RSpec workflow today)

- **Release:** `.github/workflows/release-gem.yml` — on GitHub **Release** created (`release: types: [created]`) for tag **`v*`** (draft releases skipped), checks out the tag, then builds and pushes to RubyGems (note: workflow pins Ruby 2.7 for publish; align with gemspec minimum when changing)
- **Security / compliance:** CodeQL, policy scan, SCA scan — see `.github/workflows/`
- **Issues:** Jira integration workflow in `.github/workflows/issues-jira.yml`

### Optional housekeeping

- `.talismanrc` is used for secret scanning hooks in some environments; do not commit credentials or tokens

## References

- [AGENTS.md](../../AGENTS.md)
- [Contentstack Utils SDK](../contentstack-utils/SKILL.md)
- [Framework & packaging](../framework/SKILL.md)
- [Testing](../testing/SKILL.md)

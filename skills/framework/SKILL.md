---
name: framework
description: Use when changing the gemspec, Bundler setup, Ruby/runtime constraints, or runtime dependencies (activesupport, nokogiri) and native extension implications.
---

# Framework & packaging – Contentstack Utils Ruby

## When to use

- Editing **`contentstack_utils.gemspec`** (dependencies, `required_ruby_version`, files list)
- Changing **`Gemfile`** / **`Gemfile.lock`** workflow or documenting install for contributors
- Evaluating impact of **nokogiri** (native extension) or **activesupport** version ranges on consumers

## Instructions

### Gem definition

- **`contentstack_utils.gemspec`** — canonical metadata: `s.files` from `git ls-files`, `spec/` as test files, `lib` as `require_paths`
- **`Gemfile`** — `gemspec` only; runtime and development dependencies are declared in the gemspec

### Runtime dependencies (as shipped)

- **activesupport** `>= 7.0`, `< 8`
- **nokogiri** `>= 1.13`, `< 1.19` — HTML/XML parsing for legacy string RTE paths; consumers need a compatible platform build

### Development dependencies

- **rake**, **rspec**, **webmock**, **simplecov**, **yard** — see gemspec; used for tasks in `Rakefile` and CI-style local checks

### Ruby version

- **`s.required_ruby_version`** is **>= 3.1**; `.ruby-version` pins a team default for local dev
- **Release workflow** (`.github/workflows/release-gem.yml`) uses its own Ruby pin for `gem build` / `gem push`; keep it aligned with gemspec when updating

### Build and publish

- Local artifact: `gem build contentstack_utils.gemspec`
- Publishing is triggered by GitHub **release** per `release-gem.yml`

## References

- [Development workflow](../dev-workflow/SKILL.md)
- [Contentstack Utils SDK](../contentstack-utils/SKILL.md)
- [Ruby style and layout](../ruby-style/SKILL.md)

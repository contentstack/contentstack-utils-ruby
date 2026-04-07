---
name: ruby-style
description: Use when editing Ruby in this repo—module layout, require paths, and staying consistent with existing style (not introducing a new linter config).
---

# Ruby style and layout – Contentstack Utils Ruby

## When to use

- Adding new `.rb` files under `lib/` or `spec/`
- Refactoring while keeping diffs readable for reviewers
- Deciding where a new helper or model class should live

## Instructions

### Layout

- **Library code:** `lib/contentstack_utils/` with nested folders `model/`, `interface/`, `support/`
- **Top-level require:** `lib/contentstack_utils.rb` should stay a thin loader
- **Specs:** mirror behavior under `spec/lib/` and `spec/mock/` / `spec/support/` as in existing examples

### Conventions in this codebase

- **`ContentstackUtils`** as the root module; nested **`Model`**, **`Interface`**, **`GQL`** as already used
- **`require_relative`** for internal lib files (see `utils.rb`, `options.rb`)
- Existing files use a mix of spacing and `def self.` patterns; **prefer matching the surrounding file** over wholesale reformatting
- Typo in base class name **`Rendarable`** is historical; new code should remain compatible unless a dedicated rename is approved project-wide

### Linting and format

- There is **no RuboCop or Standard** configuration in this repository; do not add large style-only churn unless the team adopts a formatter
- Run **`bundle exec rake spec`** before pushing substantive changes

### Documentation

- YARD can document public APIs; keep user-facing usage examples in `README.md` accurate (e.g. class name **`Options`** vs informal “Option” in prose)

## References

- [Contentstack Utils SDK](../contentstack-utils/SKILL.md)
- [Framework & packaging](../framework/SKILL.md)
- [Development workflow](../dev-workflow/SKILL.md)

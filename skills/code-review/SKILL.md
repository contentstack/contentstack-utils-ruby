---
name: code-review
description: Use when reviewing or preparing a PR for this gem—behavior, tests, API compatibility, and release notes.
---

# Code review – Contentstack Utils Ruby

## When to use

- Authoring a pull request that changes rendering, models, or dependencies
- Reviewing someone else’s PR before merge
- Checking release readiness (version + changelog)

## Instructions

### Blockers (fix before merge)

- **Tests:** `bundle exec rake` (or `bundle exec rspec`) passes locally
- **Breaking API:** unintended removal or signature change of public methods on **`ContentstackUtils`**, **`ContentstackUtils::GQL`**, or **`ContentstackUtils::Model::Options`** without version bump and changelog entry
- **Security:** no secrets in code, fixtures, or logs; HTML output changes reviewed for injection or XSS risk when embedding untrusted fields

### Major (should address)

- **CHANGELOG.md** updated for user-visible behavior fixes or features
- **`lib/contentstack_utils/version.rb`** updated when publishing a release (if this PR is release-bound)
- New JSON/RTE node types or GQL shapes covered by **`spec/lib/utils_spec.rb`** (or focused new spec files)
- Dependency range changes in **`contentstack_utils.gemspec`** justified and compatible with Ruby **≥ 3.1**

### Minor (nice to have)

- **README.md** examples match actual class names (**`Options`**, not a non-existent **`Option`** unless aliased)
- YARD or comments only where they clarify non-obvious RTE or GQL mapping

### Process

- Respect **CODEOWNERS** and branch policy (**`master`** vs **`staging`**) described in [dev-workflow](../dev-workflow/SKILL.md)

## References

- [AGENTS.md](../../AGENTS.md)
- [Development workflow](../dev-workflow/SKILL.md)
- [Contentstack Utils SDK](../contentstack-utils/SKILL.md)
- [Framework & packaging](../framework/SKILL.md)
- [Testing](../testing/SKILL.md)

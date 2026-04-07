---
name: contentstack-utils
description: Use when changing the public Ruby API, RTE rendering (HTML string or JSON), GQL payloads, Model::Options/Metadata, or integration boundaries with the delivery client.
---

# Contentstack Utils SDK – Contentstack Utils Ruby

## When to use

- Implementing or fixing HTML output for rich text / JSON RTE
- Extending or subclassing rendering options (`ContentstackUtils::Model::Options`)
- Parsing GraphQL-shaped RTE (`ContentstackUtils::GQL`)
- Changing load paths or public entry points under `lib/` (gemspec and dependency ranges: see [framework](../framework/SKILL.md))

## Instructions

### Entry points

- **`lib/contentstack_utils.rb`** — requires version and `utils`
- **`lib/contentstack_utils/utils.rb`** — main module **`ContentstackUtils`** with class methods:
  - **`render_content(content, options)`** — legacy HTML string RTE (array of strings or single string); uses Nokogiri and `_embedded_items` on the entry passed via options
  - **`json_to_html(content, options)`** — JSON RTE document tree (Hash/Array) for CDA-style payloads with embedded items on the entry
  - Internal helpers such as **`json_doc_to_html`** (used by GQL path)
- **`ContentstackUtils::GQL`** — **`json_to_html(content, options)`** for GraphQL responses: expects keys like `json` and optional `embedded_itemsConnection.edges`; reuses `ContentstackUtils.json_doc_to_html` with a GQL-specific reference resolver

### Models and extension points

- **`ContentstackUtils::Model::Options`** (`lib/contentstack_utils/model/options.rb`) — default **`render_option`**, **`render_mark`**, **`render_node`**; subclass for custom HTML (see tests under `spec/mock/custom_render_option.rb`)
- **`ContentstackUtils::Model::Metadata`** — built from DOM nodes (HTML path) or JSON reference nodes
- **`ContentstackUtils::Interface::Rendarable`** (`lib/contentstack_utils/interface/renderable.rb`) — base for options; implement **`render_option`** in subclasses

### Data contracts

- **CDA / delivery JSON path:** options may carry an **`entry`** hash with **`_embedded_items`** keyed by field UIDs
- **GQL path:** payload uses **`embedded_itemsConnection.edges`** with **`node`** objects; reference resolution matches **`metadata.item_uid`** to **`node.system.uid`**

### Boundaries

- HTTP and stack access belong to the separate **Contentstack Ruby** client; this gem only renders given content + embedded metadata

### Versioning

- Public API and behavior changes should be reflected in `CHANGELOG.md` and `lib/contentstack_utils/version.rb`

## References

- Product overview: [README.md](../../README.md)
- [Framework & packaging](../framework/SKILL.md)
- [Testing](../testing/SKILL.md)
- [Ruby style and layout](../ruby-style/SKILL.md)
- [Contentstack documentation](https://www.contentstack.com/docs/)

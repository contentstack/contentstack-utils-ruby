require 'spec_helper'

EMBEDDED_ASSET_WITH_DEFAULT_RENDER_OPTION = ContentstackUtils::Model::Options.new(ENTRY_EMBEDDED_ASSET)

EMBEDDED_ASSET_WITH_NO_ASSET_OBJECT = ContentstackUtils::Model::Options.new(ENTRY_ASSET_EMBED_BLANK)

EMBEDDED_ENTRY_WITH_DEFAULT_RENDER_OPTION = ContentstackUtils::Model::Options.new(ENTRY_EMBEDDED_ENTRIES)

EMBEDDED_OBJECT_WITH_DEFAULT_RENDER_OPTION = ContentstackUtils::Model::Options.new(ENTRY_EMBEDDED_OBJECTS)


EMBEDDED_ASSET_WITH_CUSTOM_RENDER_OPTION = ContentstackUtilsTest::CustomLOption.new(ENTRY_EMBEDDED_ASSET)

EMBEDDED_ENTRY_WITH_CUSTOM_RENDER_OPTION = ContentstackUtilsTest::CustomLOption.new(ENTRY_EMBEDDED_ENTRIES)

EMBEDDED_OBJECT_WITH_CUSTOM_RENDER_OPTION = ContentstackUtilsTest::CustomLOption.new(ENTRY_EMBEDDED_OBJECTS)
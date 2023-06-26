require 'spec_helper'

RSpec.describe ContentstackUtils do
    describe '#renderContent' do
        it 'Render function with blank content and options test' do
            expect(makeRenderFunction(nil)).to eq nil
            expect(makeRenderFunction('')).to eq ''
            expect(makeRenderFunction([''])).to eq ['']
        end
        it 'Render function with non html content' do
            expect(makeRenderFunction(NO_HTML)).to eq NO_HTML
            expect(makeRenderFunction([NO_HTML])).to eq [NO_HTML]
        end
        it 'Render function with html content without Embedded object' do
            expect(makeRenderFunction(SIMPLE_HTML)).to eq SIMPLE_HTML
            expect(makeRenderFunction([SIMPLE_HTML])).to eq [SIMPLE_HTML]
        end
        it 'Render function with non html content and blanks' do
            expect(makeRenderFunction([NO_HTML, ''])).to eq [NO_HTML, '']
            expect(makeRenderFunction([SIMPLE_HTML, NO_HTML])).to eq [SIMPLE_HTML, NO_HTML]
        end
        it 'Render function with non html content and blanks' do
            expect(makeRenderFunction(ENTRY_BLOCK)).to eq ''
            expect(makeRenderFunction(ENTRY_INLINE)).to eq ''
            expect(makeRenderFunction(ENTRY_LINK)).to eq ''
        end
        it 'Render Function with Embedded Asset without Options test' do
            expect(makeRenderFunction(ASSET_DISPLAY)).to eq ''
            expect(makeRenderFunction(ASSET_DOWNLOAD)).to eq ''
        end
        it 'Render Function with Embedded Entry with Options' do
            expect(makeRenderFunction(ENTRY_BLOCK, EMBEDDED_ASSET_WITH_DEFAULT_RENDER_OPTION)).to eq ''
            expect(makeRenderFunction(ENTRY_INLINE, EMBEDDED_ASSET_WITH_DEFAULT_RENDER_OPTION)).to eq ''
            expect(makeRenderFunction(ENTRY_LINK, EMBEDDED_ASSET_WITH_DEFAULT_RENDER_OPTION)).to eq ''
        end
        it 'Render Function with Embedded Entry with no items Options' do
            expect(makeRenderFunction(ENTRY_BLOCK, EMBEDDED_ASSET_WITH_NO_ASSET_OBJECT)).to eq ''
            expect(makeRenderFunction(ENTRY_INLINE, EMBEDDED_ASSET_WITH_NO_ASSET_OBJECT)).to eq ''
            expect(makeRenderFunction(ENTRY_LINK, EMBEDDED_ASSET_WITH_NO_ASSET_OBJECT)).to eq ''
        end
        it 'Render Function with Embedded Asset with Options test' do
            expect(makeRenderFunction(ASSET_DISPLAY, EMBEDDED_ASSET_WITH_DEFAULT_RENDER_OPTION)).to eq ''
            expect(makeRenderFunction(ASSET_DOWNLOAD, EMBEDDED_ASSET_WITH_DEFAULT_RENDER_OPTION)).to eq ''
            expect(makeRenderFunction(ASSET_DISPLAY, EMBEDDED_ASSET_WITH_NO_ASSET_OBJECT)).to eq ''
            expect(makeRenderFunction(ASSET_DOWNLOAD, EMBEDDED_ASSET_WITH_NO_ASSET_OBJECT)).to eq ''
        end
        it 'Render Function string of array with Embedded Entry with Options' do
            expect(makeRenderFunction([ENTRY_BLOCK])).to eq ['']
            expect(makeRenderFunction([ENTRY_BLOCK, ENTRY_INLINE])).to eq ['', '']
        end
        it 'Render Function to render Embbedded Asset test' do
            expect(makeRenderFunction(ENTRY_EMBEDDED_ASSET['rich_text_editor'], EMBEDDED_ASSET_WITH_DEFAULT_RENDER_OPTION)).to eq ENTRY_ASSET_RICH_TEXT
        end
        it 'Render Function to render Embbedded Asset with render option test' do
            expect(makeRenderFunction(ENTRY_EMBEDDED_ASSET['rich_text_editor'], EMBEDDED_ASSET_WITH_CUSTOM_RENDER_OPTION)).to eq ENTRY_ASSET_RICH_TEXT_RENDER_OPTION
        end
        it 'Render Function to render Embedded Entries with out render option test' do
            expect(makeRenderFunction(ENTRY_EMBEDDED_ENTRIES['rich_text_editor'], EMBEDDED_ENTRY_WITH_DEFAULT_RENDER_OPTION)).to eq ENTRY_MULTIPLE_RICH_TEXT
        end
    end


    describe '#JsonToHtml Array' do
        it 'Should return blank string for blank doc' do
            doc = getJson(BlankDocument)
            
            result = ContentstackUtils.json_to_html([doc], ContentstackUtils::Model::Options.new())

            expect(result).to eq [""]
        end

        it 'Should return mark text string for PlainTextJson doc' do
            doc = getJson(PlainTextJson)
            
            result = ContentstackUtils.json_to_html([doc], ContentstackUtils::Model::Options.new())
            
            expect(result).to eq [PlainTextHtml]
        end

        it 'Should return paragraph string for ParagraphJson doc' do
            doc = getJson(ParagraphJson)
            
            result = ContentstackUtils.json_to_html([doc], ContentstackUtils::Model::Options.new())
            
            expect(result).to eq [ParagraphHtml]
        end

        it 'Should return H1 string for H1Json doc' do
            doc = getJson(H1Json)
            
            result = ContentstackUtils.json_to_html([doc], ContentstackUtils::Model::Options.new())
            
            expect(result).to eq [H1Html]
        end

        it 'Should return H2 string for H2Json doc' do
            doc = getJson(H2Json)
            
            result = ContentstackUtils.json_to_html([doc], ContentstackUtils::Model::Options.new())
            
            expect(result).to eq [H2Html]
        end

        it 'Should return H3 string for H3Json doc' do
            doc = getJson(H3Json)
            
            result = ContentstackUtils.json_to_html([doc], ContentstackUtils::Model::Options.new())
            
            expect(result).to eq [H3Html]
        end

        it 'Should return H4 string for H4Json doc' do
            doc = getJson(H4Json)
            
            result = ContentstackUtils.json_to_html([doc], ContentstackUtils::Model::Options.new())
            
            expect(result).to eq [H4Html]
        end

        it 'Should return H5 string for H5Json doc' do
            doc = getJson(H5Json)
            
            result = ContentstackUtils.json_to_html([doc], ContentstackUtils::Model::Options.new())
            
            expect(result).to eq [H5Html]
        end

        it 'Should return H6 string for H6Json doc' do
            doc = getJson(H6Json)
            
            result = ContentstackUtils.json_to_html([doc], ContentstackUtils::Model::Options.new())
            
            expect(result).to eq [H6Html]
        end

        it 'Should return Order List string for OrderListJson doc' do
            doc = getJson(OrderListJson)
            
            result = ContentstackUtils.json_to_html([doc], ContentstackUtils::Model::Options.new())
            
            expect(result).to eq [OrderListHtml]
        end

        it 'Should return Unorder List string for UnorderListJson doc' do
            doc = getJson(UnorderListJson)
            
            result = ContentstackUtils.json_to_html([doc], ContentstackUtils::Model::Options.new())
            
            expect(result).to eq [UnorderListHtml]
        end

        it 'Should return image string for ImgJson doc' do
            doc = getJson(ImgJson)
            
            result = ContentstackUtils.json_to_html([doc], ContentstackUtils::Model::Options.new())
            
            expect(result).to eq [ImgHtml]
        end

        it 'Should return Blockquote string for BlockquoteJson doc' do
            doc = getJson(BlockquoteJson)
            
            result = ContentstackUtils.json_to_html([doc], ContentstackUtils::Model::Options.new())
            
            expect(result).to eq  [BlockquoteHtml]
        end

        it 'Should return Code string for CodeJson doc' do
            doc = getJson(CodeJson)
            
            result = ContentstackUtils.json_to_html([doc], ContentstackUtils::Model::Options.new())
            
            expect(result).to eq [CodeHtml]
        end

        it 'Should return Table string for TableJson doc' do
            doc = getJson(TableJson)
            
            result = ContentstackUtils.json_to_html([doc], ContentstackUtils::Model::Options.new())
            
            expect(result).to eq [TableHtml]
        end

        it 'Should return Link string for LinkInPJson doc' do
            doc = getJson(LinkInPJson)
            
            result = ContentstackUtils.json_to_html([doc], ContentstackUtils::Model::Options.new())
            
            expect(result).to eq [LinkInPHtml]
        end

        it 'Should return Embed string for EmbedJson doc' do
            doc = getJson(EmbedJson)
            
            result = ContentstackUtils.json_to_html([doc], ContentstackUtils::Model::Options.new())
            
            expect(result).to eq [EmbedHtml]
        end

        it 'Should return horizontal line string for horizontal line doc' do
            doc = getJson(HRJson)
            
            result = ContentstackUtils.json_to_html([doc], ContentstackUtils::Model::Options.new())
            
            expect(result).to eq ['<hr />']
        end
    end

    describe '#JsonToHtml' do
        it 'Should return blank string for blank doc' do
            doc = getJson(BlankDocument)
            
            result = ContentstackUtils.json_to_html(doc, ContentstackUtils::Model::Options.new())

            expect(result).to eq ""
        end

        it 'Should return mark text string for PlainTextJson doc' do
            doc = getJson(PlainTextJson)
            
            result = ContentstackUtils.json_to_html(doc, ContentstackUtils::Model::Options.new())
            
            expect(result).to eq PlainTextHtml
        end

        it 'Should return paragraph string for ParagraphJson doc' do
            doc = getJson(ParagraphJson)
            
            result = ContentstackUtils.json_to_html(doc, ContentstackUtils::Model::Options.new())
            
            expect(result).to eq ParagraphHtml
        end

        it 'Should return H1 string for H1Json doc' do
            doc = getJson(H1Json)
            
            result = ContentstackUtils.json_to_html(doc, ContentstackUtils::Model::Options.new())
            
            expect(result).to eq H1Html
        end

        it 'Should return H2 string for H2Json doc' do
            doc = getJson(H2Json)
            
            result = ContentstackUtils.json_to_html(doc, ContentstackUtils::Model::Options.new())
            
            expect(result).to eq H2Html
        end

        it 'Should return H3 string for H3Json doc' do
            doc = getJson(H3Json)
            
            result = ContentstackUtils.json_to_html(doc, ContentstackUtils::Model::Options.new())
            
            expect(result).to eq H3Html
        end

        it 'Should return H4 string for H4Json doc' do
            doc = getJson(H4Json)
            
            result = ContentstackUtils.json_to_html(doc, ContentstackUtils::Model::Options.new())
            
            expect(result).to eq H4Html
        end

        it 'Should return H5 string for H5Json doc' do
            doc = getJson(H5Json)
            
            result = ContentstackUtils.json_to_html(doc, ContentstackUtils::Model::Options.new())
            
            expect(result).to eq H5Html
        end

        it 'Should return H6 string for H6Json doc' do
            doc = getJson(H6Json)
            
            result = ContentstackUtils.json_to_html(doc, ContentstackUtils::Model::Options.new())
            
            expect(result).to eq H6Html
        end

        it 'Should return Order List string for OrderListJson doc' do
            doc = getJson(OrderListJson)
            
            result = ContentstackUtils.json_to_html(doc, ContentstackUtils::Model::Options.new())
            
            expect(result).to eq OrderListHtml
        end

        it 'Should return Unorder List string for UnorderListJson doc' do
            doc = getJson(UnorderListJson)
            
            result = ContentstackUtils.json_to_html(doc, ContentstackUtils::Model::Options.new())
            
            expect(result).to eq UnorderListHtml
        end

        it 'Should return image string for ImgJson doc' do
            doc = getJson(ImgJson)
            
            result = ContentstackUtils.json_to_html(doc, ContentstackUtils::Model::Options.new())
            
            expect(result).to eq ImgHtml
        end

        it 'Should return Blockquote string for BlockquoteJson doc' do
            doc = getJson(BlockquoteJson)
            
            result = ContentstackUtils.json_to_html(doc, ContentstackUtils::Model::Options.new())
            
            expect(result).to eq  BlockquoteHtml
        end

        it 'Should return Code string for CodeJson doc' do
            doc = getJson(CodeJson)
            
            result = ContentstackUtils.json_to_html(doc, ContentstackUtils::Model::Options.new())
            
            expect(result).to eq CodeHtml
        end

        it 'Should return Table string for TableJson doc' do
            doc = getJson(TableJson)
            
            result = ContentstackUtils.json_to_html(doc, ContentstackUtils::Model::Options.new())
            
            expect(result).to eq TableHtml
        end

        it 'Should return Link string for LinkInPJson doc' do
            doc = getJson(LinkInPJson)
            
            result = ContentstackUtils.json_to_html(doc, ContentstackUtils::Model::Options.new())
            
            expect(result).to eq LinkInPHtml
        end

        it 'Should return Embed string for EmbedJson doc' do
            doc = getJson(EmbedJson)
            
            result = ContentstackUtils.json_to_html(doc, ContentstackUtils::Model::Options.new())
            
            expect(result).to eq EmbedHtml
        end

        it 'Should return horizontal line string for horizontal line doc' do
            doc = getJson(HRJson)
            
            result = ContentstackUtils.json_to_html(doc, ContentstackUtils::Model::Options.new())
            
            expect(result).to eq '<hr />'
        end

        it 'Should return horizontal line string for horizontal line doc' do
            doc = getJson(H1NonChildJson)
            
            result = ContentstackUtils.json_to_html(doc, ContentstackUtils::Model::Options.new())
            
            expect(result).to eq '<h1></h1>'
        end
    end

    describe '#JsonToHtml reference' do
        it 'Should return blank string for non entry option' do 
            doc = getJson(AssetReferenceJson)

            result = ContentstackUtils.json_to_html(doc, ContentstackUtils::Model::Options.new())
            
            expect(result).to eq ''
        end

        it 'Should return asset embedded items' do 
            doc = getJson(AssetReferenceJson)

            result = ContentstackUtils.json_to_html(doc, ContentstackUtils::Model::Options.new(JSON_EMBEDDED_ITEMS_ENTRY))
            
            expect(result).to eq AssetReferenceHtml
        end

        it 'Should return asset embedded items for assest-link' do 
            doc = getJson(AssetReferenceJson)

            result = ContentstackUtils.json_to_html(doc, ContentstackUtils::Model::Options.new(JSON_EMBEDDED_ITEMS_ENTRY))
            
            expect(result).to eq "<img src='/v3/dummy.pdf' alt='dummy.pdf' />"
        end

        it 'Should return entry block embedded items' do 
            doc = getJson(EntryReferenceBlockJson)

            result = ContentstackUtils.json_to_html(doc, ContentstackUtils::Model::Options.new(JSON_EMBEDDED_ITEMS_ENTRY))
            
            expect(result).to eq EntryReferenceBlockHtml
        end

        it 'Should return entry link embedded items' do 
            doc = getJson(EntryReferenceLinkJson)

            result = ContentstackUtils.json_to_html(doc, ContentstackUtils::Model::Options.new(JSON_EMBEDDED_ITEMS_ENTRY))
            
            expect(result).to eq EntryReferenceLinkHtml
        end

        it 'Should return entry inline embedded items' do 
            doc = getJson(EntryReferenceInlineJson)

            result = ContentstackUtils.json_to_html(doc, ContentstackUtils::Model::Options.new(JSON_EMBEDDED_ITEMS_ENTRY))
            
            expect(result).to eq EntryReferenceInlineHtml
        end

       
    end
    describe 'GQL #JsonToHtml' do
        it 'Should return blank string for blank doc' do
            entry = getGQLJSONRTE(BlankDocument)

            result = ContentstackUtils::GQL.json_to_html(entry['single_rte'], ContentstackUtils::Model::Options.new())
            arrayResult = ContentstackUtils::GQL.json_to_html(entry['multiple_rte'], ContentstackUtils::Model::Options.new())

            expect(result).to eq ""
            expect(arrayResult).to eq [""]
        end

        it 'Should return mark text string for PlainTextJson doc' do
            entry = getGQLJSONRTE(PlainTextJson)

            result = ContentstackUtils::GQL.json_to_html(entry['single_rte'], ContentstackUtils::Model::Options.new())
            arrayResult = ContentstackUtils::GQL.json_to_html(entry['multiple_rte'], ContentstackUtils::Model::Options.new())

            expect(result).to eq PlainTextHtml
            expect(arrayResult).to eq [PlainTextHtml]
        end

        it 'Should return paragraph string for ParagraphJson doc' do
            entry = getGQLJSONRTE(ParagraphJson)

            result = ContentstackUtils::GQL.json_to_html(entry['single_rte'], ContentstackUtils::Model::Options.new())
            arrayResult = ContentstackUtils::GQL.json_to_html(entry['multiple_rte'], ContentstackUtils::Model::Options.new())

            expect(result).to eq ParagraphHtml
            expect(arrayResult).to eq [ParagraphHtml]
        end

        it 'Should return H1 string for H1Json doc' do
            entry = getGQLJSONRTE(H1Json)

            result = ContentstackUtils::GQL.json_to_html(entry['single_rte'], ContentstackUtils::Model::Options.new())
            arrayResult = ContentstackUtils::GQL.json_to_html(entry['multiple_rte'], ContentstackUtils::Model::Options.new())

            expect(result).to eq H1Html
            expect(arrayResult).to eq [H1Html]
        end

        it 'Should return H2 string for H1Json doc' do
            entry = getGQLJSONRTE(H2Json)

            result = ContentstackUtils::GQL.json_to_html(entry['single_rte'], ContentstackUtils::Model::Options.new())
            arrayResult = ContentstackUtils::GQL.json_to_html(entry['multiple_rte'], ContentstackUtils::Model::Options.new())

            expect(result).to eq H2Html
            expect(arrayResult).to eq [H2Html]
        end

        it 'Should return H3 string for H1Json doc' do
            entry = getGQLJSONRTE(H3Json)

            result = ContentstackUtils::GQL.json_to_html(entry['single_rte'], ContentstackUtils::Model::Options.new())
            arrayResult = ContentstackUtils::GQL.json_to_html(entry['multiple_rte'], ContentstackUtils::Model::Options.new())

            expect(result).to eq H3Html
            expect(arrayResult).to eq [H3Html]
        end

        it 'Should return H4 string for H1Json doc' do
            entry = getGQLJSONRTE(H4Json)

            result = ContentstackUtils::GQL.json_to_html(entry['single_rte'], ContentstackUtils::Model::Options.new())
            arrayResult = ContentstackUtils::GQL.json_to_html(entry['multiple_rte'], ContentstackUtils::Model::Options.new())

            expect(result).to eq H4Html
            expect(arrayResult).to eq [H4Html]
        end

        it 'Should return H5 string for H1Json doc' do
            entry = getGQLJSONRTE(H5Json)

            result = ContentstackUtils::GQL.json_to_html(entry['single_rte'], ContentstackUtils::Model::Options.new())
            arrayResult = ContentstackUtils::GQL.json_to_html(entry['multiple_rte'], ContentstackUtils::Model::Options.new())

            expect(result).to eq H5Html
            expect(arrayResult).to eq [H5Html]
        end

        it 'Should return H6 string for H1Json doc' do
            entry = getGQLJSONRTE(H6Json)

            result = ContentstackUtils::GQL.json_to_html(entry['single_rte'], ContentstackUtils::Model::Options.new())
            arrayResult = ContentstackUtils::GQL.json_to_html(entry['multiple_rte'], ContentstackUtils::Model::Options.new())

            expect(result).to eq H6Html
            expect(arrayResult).to eq [H6Html]
        end

        it 'Should return Order List string for OrderListJson doc' do
            entry = getGQLJSONRTE(OrderListJson)

            result = ContentstackUtils::GQL.json_to_html(entry['single_rte'], ContentstackUtils::Model::Options.new())
            arrayResult = ContentstackUtils::GQL.json_to_html(entry['multiple_rte'], ContentstackUtils::Model::Options.new())

            expect(result).to eq OrderListHtml
            expect(arrayResult).to eq [OrderListHtml]
        end

        it 'Should return Unorder List string for UnorderListJson doc' do
            entry = getGQLJSONRTE(UnorderListJson)

            result = ContentstackUtils::GQL.json_to_html(entry['single_rte'], ContentstackUtils::Model::Options.new())
            arrayResult = ContentstackUtils::GQL.json_to_html(entry['multiple_rte'], ContentstackUtils::Model::Options.new())

            expect(result).to eq UnorderListHtml
            expect(arrayResult).to eq [UnorderListHtml]
        end

        it 'Should return image string for ImgJson doc' do
            entry = getGQLJSONRTE(ImgJson)

            result = ContentstackUtils::GQL.json_to_html(entry['single_rte'], ContentstackUtils::Model::Options.new())
            arrayResult = ContentstackUtils::GQL.json_to_html(entry['multiple_rte'], ContentstackUtils::Model::Options.new())

            expect(result).to eq ImgHtml
            expect(arrayResult).to eq [ImgHtml]
        end

        it 'Should return Blockquote string for BlockquoteJson doc' do
            entry = getGQLJSONRTE(BlockquoteJson)

            result = ContentstackUtils::GQL.json_to_html(entry['single_rte'], ContentstackUtils::Model::Options.new())
            arrayResult = ContentstackUtils::GQL.json_to_html(entry['multiple_rte'], ContentstackUtils::Model::Options.new())

            expect(result).to eq BlockquoteHtml
            expect(arrayResult).to eq [BlockquoteHtml]
        end

        it 'Should return Code string for CodeJson doc' do
            entry = getGQLJSONRTE(CodeJson)

            result = ContentstackUtils::GQL.json_to_html(entry['single_rte'], ContentstackUtils::Model::Options.new())
            arrayResult = ContentstackUtils::GQL.json_to_html(entry['multiple_rte'], ContentstackUtils::Model::Options.new())

            expect(result).to eq CodeHtml
            expect(arrayResult).to eq [CodeHtml]
        end

        it 'Should return Table string for TableJson doc' do
            entry = getGQLJSONRTE(TableJson)

            result = ContentstackUtils::GQL.json_to_html(entry['single_rte'], ContentstackUtils::Model::Options.new())
            arrayResult = ContentstackUtils::GQL.json_to_html(entry['multiple_rte'], ContentstackUtils::Model::Options.new())

            expect(result).to eq TableHtml
            expect(arrayResult).to eq [TableHtml]
        end

        it 'Should return Link string for LinkInPJson doc' do
            entry = getGQLJSONRTE(LinkInPJson)

            result = ContentstackUtils::GQL.json_to_html(entry['single_rte'], ContentstackUtils::Model::Options.new())
            arrayResult = ContentstackUtils::GQL.json_to_html(entry['multiple_rte'], ContentstackUtils::Model::Options.new())

            expect(result).to eq LinkInPHtml
            expect(arrayResult).to eq [LinkInPHtml]
        end

        it 'Should return Embed string for EmbedJson doc' do
            entry = getGQLJSONRTE(EmbedJson)

            result = ContentstackUtils::GQL.json_to_html(entry['single_rte'], ContentstackUtils::Model::Options.new())
            arrayResult = ContentstackUtils::GQL.json_to_html(entry['multiple_rte'], ContentstackUtils::Model::Options.new())

            expect(result).to eq EmbedHtml
            expect(arrayResult).to eq [EmbedHtml]
        end

        it 'Should return horizontal line string for horizontal line doc' do
            entry = getGQLJSONRTE(HRJson)

            result = ContentstackUtils::GQL.json_to_html(entry['single_rte'], ContentstackUtils::Model::Options.new())
            arrayResult = ContentstackUtils::GQL.json_to_html(entry['multiple_rte'], ContentstackUtils::Model::Options.new())

            expect(result).to eq '<hr />'
            expect(arrayResult).to eq ['<hr />']
        end
    end

    describe 'GQL #JsonToHtml reference' do
        it 'Should return blank string for non entry option' do 
            entry = getGQLJSONRTE(AssetReferenceJson)

            result = ContentstackUtils::GQL.json_to_html(entry['single_rte'], ContentstackUtils::Model::Options.new())
            arrayResult = ContentstackUtils::GQL.json_to_html(entry['multiple_rte'], ContentstackUtils::Model::Options.new())

            expect(result).to eq ''
            expect(arrayResult).to eq ['']
        end

        it 'Should return asset embedded items' do 
            entry = getGQLJSONRTE(AssetReferenceJson, EmbedEdges)

            result = ContentstackUtils::GQL.json_to_html(entry['single_rte'], ContentstackUtils::Model::Options.new())
            arrayResult = ContentstackUtils::GQL.json_to_html(entry['multiple_rte'], ContentstackUtils::Model::Options.new())

            expect(result).to eq AssetReferenceHtml
            expect(arrayResult).to eq [AssetReferenceHtml]
        end

        it 'Should return entry block embedded items' do 
            entry = getGQLJSONRTE(EntryReferenceBlockJson, EmbedEdges)

            result = ContentstackUtils::GQL.json_to_html(entry['single_rte'], ContentstackUtils::Model::Options.new())
            arrayResult = ContentstackUtils::GQL.json_to_html(entry['multiple_rte'], ContentstackUtils::Model::Options.new())

            expect(result).to eq EntryReferenceBlockHtml
            expect(arrayResult).to eq [EntryReferenceBlockHtml]
        end

        it 'Should return entry link embedded items' do 
            entry = getGQLJSONRTE(EntryReferenceLinkJson, EmbedEdges)

            result = ContentstackUtils::GQL.json_to_html(entry['single_rte'], ContentstackUtils::Model::Options.new())
            arrayResult = ContentstackUtils::GQL.json_to_html(entry['multiple_rte'], ContentstackUtils::Model::Options.new())

            expect(result).to eq EntryReferenceLinkHtml
            expect(arrayResult).to eq [EntryReferenceLinkHtml]
        end

        it 'Should return entry inline embedded items' do 
            entry = getGQLJSONRTE(EntryReferenceInlineJson, EmbedEdges)

            result = ContentstackUtils::GQL.json_to_html(entry['single_rte'], ContentstackUtils::Model::Options.new())
            arrayResult = ContentstackUtils::GQL.json_to_html(entry['multiple_rte'], ContentstackUtils::Model::Options.new())

            expect(result).to eq EntryReferenceInlineHtml
            expect(arrayResult).to eq [EntryReferenceInlineHtml]
        end
    end

    def makeRenderFunction(content, option = ContentstackUtils::Model::Options.new(ENTRY_EMBEDDED_ASSET)) 
        ContentstackUtils.render_content(content, option)
    end
end
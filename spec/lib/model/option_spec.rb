require 'spec_helper'

def getMetadata(itemType=nil, styleType=nil, linkText=nil)
    html = "<test type='#{itemType || 'entry'}' sys-style-type='#{styleType || 'block'}'>#{linkText || ''}</test>";
    element = getElement(html, '//test')[0]
    ContentstackUtils::Model::Metadata.new(element)
end
RSpec.describe ContentstackUtils::Model::Options do
    subject {described_class.new({})}
    linkText = "Text To set Link"
    describe 'Custom Raise Render' do
        it 'Custom render without render implementation should fail' do
            expect{ ContentstackUtilsTest::CustomRaiseOption.new.render_option(ENTRY_CONTENT_BLANK, getMetadata()) }.to raise_error(NotImplementedError, "Implement this method in a child class")
        end
    end

    describe 'Default Option' do
        it 'Embedded Content Type Entry' do
            expect(subject.render_option(ENTRY_CONTENT_BLANK, getMetadata())).
            to eq "<div><p>uid</p><p>Content type: <span>content_type_uid</span></p></div>"
            expect(subject.render_option(ENTRY_CONTENT_BLANK, getMetadata('entry', 'inline'))).
            to eq "<span>uid</span>"
            expect(subject.render_option(ENTRY_CONTENT_BLANK, getMetadata('entry', 'link'))).
            to eq "<a href='uid'>uid</a>"
        end

        it 'Embedded Entry' do
            expect(subject.render_option(ENTRY_CONTENT_TITLE, getMetadata())).
            to eq "<div><p>title</p><p>Content type: <span>content_type_uid</span></p></div>"
            expect(subject.render_option(ENTRY_CONTENT_TITLE, getMetadata('entry', 'inline'))).
            to eq "<span>title</span>"
            expect(subject.render_option(ENTRY_CONTENT_TITLE, getMetadata('entry', 'link'))).
            to eq "<a href='title'>title</a>"
        end

        it 'Embedded Entry URL' do
            expect(subject.render_option(ENTRY_CONTENT_TITLE_URL, getMetadata())).
            to eq "<div><p>title</p><p>Content type: <span>content_type_uid</span></p></div>"
            expect(subject.render_option(ENTRY_CONTENT_TITLE_URL, getMetadata('entry', 'inline'))).
            to eq "<span>title</span>"
            expect(subject.render_option(ENTRY_CONTENT_TITLE_URL, getMetadata('entry', 'link'))).
            to eq "<a href='url'>title</a>"
        end

        it 'Embedded Asset' do
            expect(subject.render_option(ASSET_CONTENT_URL, getMetadata('asset', 'display'))).
            to eq "<img src='url' alt='title' />"
            expect(subject.render_option(ASSET_CONTENT_URL, getMetadata('entry', 'download'))).
            to eq "<a href='url'>title</a>"
        end

        it 'Embedded Content Type Entry with text' do
            expect(subject.render_option(ENTRY_CONTENT_BLANK, getMetadata('entry', 'block', linkText))).
            to eq "<div><p>uid</p><p>Content type: <span>content_type_uid</span></p></div>"
            expect(subject.render_option(ENTRY_CONTENT_BLANK, getMetadata('entry', 'inline', linkText))).
            to eq "<span>uid</span>"
            expect(subject.render_option(ENTRY_CONTENT_BLANK, getMetadata('entry', 'link', linkText))).
            to eq "<a href='uid'>#{linkText}</a>"
        end

        it 'Embedded Entry with text' do
            expect(subject.render_option(ENTRY_CONTENT_TITLE, getMetadata('entry', 'block', linkText))).
            to eq "<div><p>title</p><p>Content type: <span>content_type_uid</span></p></div>"
            expect(subject.render_option(ENTRY_CONTENT_TITLE, getMetadata('entry', 'inline', linkText))).
            to eq "<span>title</span>"
            expect(subject.render_option(ENTRY_CONTENT_TITLE, getMetadata('entry', 'link', linkText))).
            to eq "<a href='title'>#{linkText}</a>"
        end

        it 'Embedded Entry URL with text' do
            expect(subject.render_option(ENTRY_CONTENT_TITLE_URL, getMetadata('entry', 'block', linkText))).
            to eq "<div><p>title</p><p>Content type: <span>content_type_uid</span></p></div>"
            expect(subject.render_option(ENTRY_CONTENT_TITLE_URL, getMetadata('entry', 'inline', linkText))).
            to eq "<span>title</span>"
            expect(subject.render_option(ENTRY_CONTENT_TITLE_URL, getMetadata('entry', 'link', linkText))).
            to eq "<a href='url'>#{linkText}</a>"
        end

        it 'Embedded Asset with text' do
            expect(subject.render_option(ASSET_CONTENT_URL, getMetadata('asset', 'display', linkText))).
            to eq "<img src='url' alt='title' />"
            expect(subject.render_option(ASSET_CONTENT_URL, getMetadata('entry', 'download', linkText))).
            to eq "<a href='url'>#{linkText}</a>"
        end

        it 'Should return Mark text html' do
            expect(subject.render_mark('bold', linkText)).
            to eq "<strong>#{linkText}</strong>"
            expect(subject.render_mark('italic', linkText)).
            to eq "<em>#{linkText}</em>"
            expect(subject.render_mark('underline', linkText)).
            to eq "<u>#{linkText}</u>"
            expect(subject.render_mark('strikethrough', linkText)).
            to eq "<strike>#{linkText}</strike>"
            expect(subject.render_mark('inlineCode', linkText)).
            to eq "<span>#{linkText}</span>"
            expect(subject.render_mark('subscript', linkText)).
            to eq "<sub>#{linkText}</sub>"
            expect(subject.render_mark('superscript', linkText)).
            to eq "<sup>#{linkText}</sup>"
            expect(subject.render_mark('break', linkText)).
            to eq "<br />"
            expect(subject.render_mark('', linkText)).
            to eq linkText
        end

        it 'Should return blank string for doc node type' do
             doc = getJson(BlankDocument)

             result = subject.render_node('doc', doc, linkText)
             expect(result).to eq ""
        end

        it 'Should return paragraph string for paragrpah node type' do
            doc = getJson(BlankDocument)

            result = subject.render_node('p', doc, linkText)
            expect(result).to eq "<p>#{linkText}</p>"
        end

        it 'Should return link string with blank href for link node type' do
            doc = getJson(BlankDocument)

            result = subject.render_node('a', doc, linkText)
            expect(result).to eq "<a href=''>#{linkText}</a>"
        end

        it 'Should return link string for link node type' do
            doc = getJson(LinkInPJson)["children"][0]

            result = subject.render_node('a', doc, linkText)
            expect(result).to eq "<a href='#{doc["attrs"]["href"]}'>#{linkText}</a>"
        end

        it 'Should return image string with blank src for image node type' do
            doc = getJson(BlankDocument)

            result = subject.render_node('img', doc, linkText)
            expect(result).to eq "<img src='' />#{linkText}"
        end

        it 'Should return link string for link node type' do
            doc = getJson(ImgJson)["children"][0]

            result = subject.render_node('img', doc, linkText)
            expect(result).to eq "<img src='#{doc["attrs"]["src"]}' />#{linkText}"
        end

        it 'Should return link string for link node type' do
            doc = getJson(ImgJsonURL)["children"][0]

            result = subject.render_node('img', doc, linkText)
            expect(result).to eq "<img src='#{doc["attrs"]["url"]}' />#{linkText}"
        end

        it 'Should return embed string with blank src for embed node type' do
            doc = getJson(BlankDocument)

            result = subject.render_node('embed', doc, linkText)
            expect(result).to eq "<iframe src=''></iframe>"
        end

        it 'Should return embed string for embed node type' do
            doc = getJson(EmbedJson)["children"][0]

            result = subject.render_node('embed', doc, linkText)
            expect(result).to eq "<iframe src='#{doc["attrs"]["src"]}'></iframe>"
        end

        it 'Should return Heading 1 string for Heading 1 node type' do
            doc = getJson(BlankDocument)

            result = subject.render_node('h1', doc, linkText)
            expect(result).to eq "<h1>#{linkText}</h1>"
        end

        it 'Should return Heading 2 string for Heading 2 node type' do
            doc = getJson(BlankDocument)

            result = subject.render_node('h2', doc, linkText)
            expect(result).to eq "<h2>#{linkText}</h2>"
        end

        it 'Should return Heading 3 string for Heading 3 node type' do
            doc = getJson(BlankDocument)

            result = subject.render_node('h3', doc, linkText)
            expect(result).to eq "<h3>#{linkText}</h3>"
        end

        it 'Should return Heading 4 string for Heading 4 node type' do
            doc = getJson(BlankDocument)

            result = subject.render_node('h4', doc, linkText)
            expect(result).to eq "<h4>#{linkText}</h4>"
        end

        it 'Should return Heading 5 string for Heading 5 node type' do
            doc = getJson(BlankDocument)

            result = subject.render_node('h5', doc, linkText)
            expect(result).to eq "<h5>#{linkText}</h5>"
        end

        it 'Should return Heading 6 string for Heading 6 node type' do
            doc = getJson(BlankDocument)

            result = subject.render_node('h6', doc, linkText)
            expect(result).to eq "<h6>#{linkText}</h6>"
        end

        it 'Should return Hr string for Hr node type' do
            doc = getJson(BlankDocument)

            result = subject.render_node('hr', doc, linkText)
            expect(result).to eq "<hr />"
        end

        it 'Should return order list string for order list node type' do
            doc = getJson(BlankDocument)

            result = subject.render_node('ol', doc, linkText)
            expect(result).to eq "<ol>#{linkText}</ol>"
        end

        it 'Should return Unorder list string for Unorder list node type' do
            doc = getJson(BlankDocument)

            result = subject.render_node('ul', doc, linkText)
            expect(result).to eq "<ul>#{linkText}</ul>"
        end

        it 'Should return list item string for list item node type' do
            doc = getJson(BlankDocument)

            result = subject.render_node('li', doc, linkText)
            expect(result).to eq "<li>#{linkText}</li>"
        end

        it 'Should return table string for table node type' do
            doc = getJson(BlankDocument)

            result = subject.render_node('table', doc, linkText)
            expect(result).to eq "<table>#{linkText}</table>"
        end

        it 'Should return thead string for thead node type' do
            doc = getJson(BlankDocument)

            result = subject.render_node('thead', doc, linkText)
            expect(result).to eq "<thead>#{linkText}</thead>"
        end

        it 'Should return tfoot string for tfoot node type' do
            doc = getJson(BlankDocument)

            result = subject.render_node('tfoot', doc, linkText)
            expect(result).to eq "<tfoot>#{linkText}</tfoot>"
        end

        it 'Should return tbody string fortbody node type' do
            doc = getJson(BlankDocument)

            result = subject.render_node('tbody', doc, linkText)
            expect(result).to eq "<tbody>#{linkText}</tbody>"
        end

        it 'Should return table row string for table row node type' do
            doc = getJson(BlankDocument)

            result = subject.render_node('tr', doc, linkText)
            expect(result).to eq "<tr>#{linkText}</tr>"
        end

        it 'Should return table head string for table head node type' do
            doc = getJson(BlankDocument)

            result = subject.render_node('th', doc, linkText)
            expect(result).to eq "<th>#{linkText}</th>"
        end

        it 'Should return table data string for table data node type' do
            doc = getJson(BlankDocument)

            result = subject.render_node('td', doc, linkText)
            expect(result).to eq "<td>#{linkText}</td>"
        end

        it 'Should return blockquote string for blockquote node type' do
            doc = getJson(BlankDocument)

            result = subject.render_node('blockquote', doc, linkText)
            expect(result).to eq "<blockquote>#{linkText}</blockquote>"
        end

        it 'Should return code string for code node type' do
            doc = getJson(BlankDocument)

            result = subject.render_node('code', doc, linkText)
            expect(result).to eq "<code>#{linkText}</code>"
        end

        it 'Should return blank string for reference node type' do
            doc = getJson(BlankDocument)

            result = subject.render_node('reference', doc, linkText)
            expect(result).to eq ""
        end

        it 'Should return span string for span node type' do
            doc = getJson(BlankDocument)

            result = subject.render_node('span', doc, linkText)
            expect(result).to eq "<span>#{linkText}</span>"
        end

    end
end

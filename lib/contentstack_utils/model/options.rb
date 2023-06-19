require_relative '../interface/renderable.rb'
require_relative './metadata.rb'

module ContentstackUtils
    module Model
        class Options < Interface::Rendarable

            def initialize(entry = nil)
                @entry = entry
            end

            def entry 
                @entry
            end

            def render_option(embeddedObject, metadata)
                renderString = ''
                case metadata.style_type
                when 'block'
                    renderString = "<div><p>#{embeddedObject['title'] || embeddedObject['uid']}</p><p>Content type: <span>#{embeddedObject['_content_type_uid'] || embeddedObject['system']['content_type_uid']}</span></p></div>"
                when 'inline'
                    renderString = "<span>#{embeddedObject["title"] || embeddedObject["uid"]}</span>";
                when 'link'
                    metadata.get_attribute_value("href")
                    renderString = "<a href='#{metadata.get_attribute_value("href") || embeddedObject["url"] || embeddedObject["title"] || embeddedObject["uid"]}'>#{(metadata.text && metadata.text != '' ? metadata.text : (embeddedObject["title"] || embeddedObject["uid"]))}</a>";
                when 'display'
                    renderString = "<img src='#{metadata.get_attribute_value("src")|| embeddedObject["url"]}' alt='#{(metadata.attributes["alt"] ? metadata.attributes["alt"].value : (embeddedObject["title"] || embeddedObject["filename"] || embeddedObject["uid"]))}' />";
                when 'download'
                    renderString = "<a href='#{metadata.get_attribute_value("href") || embeddedObject["url"]}'>#{(metadata.text && metadata.text != '' ? metadata.text : (embeddedObject["filename"] || embeddedObject["title"] || embeddedObject["uid"]))}</a>";
                end
                renderString
            end

            def render_mark(mark_type, text)
                renderString = text
                case mark_type
                when 'bold'
                    renderString = "<strong>#{text}</strong>"
                when 'italic'
                    renderString = "<em>#{text}</em>"
                when 'underline'
                    renderString = "<u>#{text}</u>"
                when 'strikethrough'
                    renderString = "<strike>#{text}</strike>"
                when 'inlineCode'
                    renderString = "<span>#{text}</span>"
                when 'subscript'
                    renderString = "<sub>#{text}</sub>"
                when 'superscript'
                    renderString = "<sup>#{text}</sup>"
                when 'br'
                    renderString = "<br />"
                end
                renderString
            end

            def render_node(node_type, node, inner_html)
                renderString = ""
                case node_type
                when 'doc'
                    renderString = ""
                when 'p'
                    renderString = "<p>#{inner_html}</p>"
                when 'a'
                    renderString = "<a href='#{node["attrs"]["href"] || node["attrs"]["url"] || ""}'>#{inner_html}</a>"
                when 'img'
                    renderString = "<img src='#{node["attrs"]["src"] || node["attrs"]["url"]  || ""}' />#{inner_html}"
                when 'embed'
                    renderString = "<iframe src='#{node["attrs"]["src"] || node["attrs"]["url"]  || ""}'></iframe>"
                when 'h1'
                    renderString = "<h1>#{inner_html}</h1>"
                when 'h2'
                    renderString = "<h2>#{inner_html}</h2>"
                when 'h3'
                    renderString = "<h3>#{inner_html}</h3>"
                when 'h4'
                    renderString = "<h4>#{inner_html}</h4>"
                when 'h5'
                    renderString = "<h5>#{inner_html}</h5>"
                when 'h6'
                    renderString = "<h6>#{inner_html}</h6>"
                when 'ol'
                    renderString = "<ol>#{inner_html}</ol>"
                when 'ul'
                    renderString = "<ul>#{inner_html}</ul>"
                when 'li'
                    renderString = "<li>#{inner_html}</li>"
                when 'hr'
                    renderString = "<hr />"
                when 'br'
                    renderString = "<br />"
                when 'table'
                    renderString = "<table>#{inner_html}</table>"
                when 'thead'
                    renderString = "<thead>#{inner_html}</thead>"
                when 'tbody'
                    renderString = "<tbody>#{inner_html}</tbody>"
                when 'tfoot'
                    renderString = "<tfoot>#{inner_html}</tfoot>"
                when 'tr'
                    renderString = "<tr>#{inner_html}</tr>"
                when 'th'
                    renderString = "<th>#{inner_html}</th>"
                when 'td'
                    renderString = "<td>#{inner_html}</td>"
                when 'blockquote'
                    renderString = "<blockquote>#{inner_html}</blockquote>"
                when 'code'
                    renderString = "<code>#{inner_html}</code>"
                when 'reference'
                    renderString = ""
                when 'span'
                    renderString = "<span>#{inner_html}</span>"
                end
                renderString
            end
        end
    end
end

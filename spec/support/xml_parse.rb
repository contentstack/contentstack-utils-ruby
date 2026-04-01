def getElement(xml, query) 
    xml_doc = Nokogiri::XML(xml)
    xml_doc.xpath(query)
end

def appendFrame(string)
    "<documentfragmentcontainer>#{string}</documentfragmentcontainer>"
end

def getHTML(xml) 
    xml_doc = Nokogiri::XML(appendFrame(xml))
    xml_doc.xpath('//documentfragmentcontainer').inner_html
end

def getJson(text)
    JSON.parse(text)
end

def getGQLJSONRTE(node, item = '""')
    normalized_node = node
    if node.is_a?(Hash) && node["type"] != "doc" && node[:type] != "doc"
        normalized_node = { "type" => "doc", "children" => [node] }
    end

    node_payload = normalized_node.is_a?(String) ? normalized_node : JSON.generate(normalized_node)
    item_payload = item.is_a?(String) ? item : JSON.generate(item)

    entry = "{
        \"single_rte\": {
            \"json\": #{node_payload},
            \"embedded_itemsConnection\": #{item_payload}
        },
        \"multiple_rte\": {
            \"json\": [#{node_payload}],
            \"embedded_itemsConnection\": #{item_payload}
        }
    }"
    getJson(entry)
end
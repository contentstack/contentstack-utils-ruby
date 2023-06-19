require_relative './model/options.rb'
require_relative './model/metadata.rb'
require_relative './support/helper.rb'
require 'nokogiri'

module ContentstackUtils
    def self.render_content(content, options)
        if (content.instance_of? Array)
            result = []
            content.each do |n|
                result.push(render_string(n, options))
            end
            result
        elsif content.instance_of? String
            render_string(content, options)
        end
    end

    def self.json_to_html(content, options)
        reference = -> (metadata){
            result = ""
            if options.entry != nil
                object = findObject(metadata, options.entry)
                if object!= nil && object.length() > 0 
                    result = options.render_option(object[0], metadata)
                else
                    content.each do |node|
                        inner_html = json_doc_to_html(node, options, reference)
                        result =  options.render_node(node["type"], node, inner_html)
                    end
                end
            end
            result
         }
        if (content.instance_of? Array)
            result = []
            content.each do |n|
                result.push(json_doc_to_html(n, options, reference) )
            end
            result
        elsif content.instance_of? Hash
            json_doc_to_html(content, options, reference)
        end
    end

    def self.json_doc_to_html(node, options, callback)
        result = ""
        if node["children"] && node["children"].length() > 0
            result = node_children_to_html(node["children"], options, callback)
        end
        result
    end

    private_class_method def self.node_children_to_html(nodes, options, callback) 
        nodes.map {|node| node_to_html(node, options, callback)}.join("")
    end

    private_class_method def self.node_to_html(node, options, callback)
        html_result = ""
        if node["type"] == nil && node["text"] 
            html_result = text_to_htms(node, options)            
        elsif node["type"]
            if node["type"] == "reference"
                metadata = Model::Metadata.new(node)
                html_result = callback.call(metadata)
            else
                inner_html = json_doc_to_html(node, options, callback)
                html_result =  options.render_node(node["type"], node, inner_html)
            end 
        end
        html_result
    end

    private_class_method def self.text_to_htms(node, options)
        text = node["text"]
        if node["superscript"]
            text = options.render_mark("superscript", text)
        end
        if node["subscript"]
            text = options.render_mark("subscript", text)
        end
        if node["inlineCode"]
            text = options.render_mark("inlineCode", text)
        end
        if node["strikethrough"]
            text = options.render_mark("strikethrough", text)
        end
        if node["underline"]
            text = options.render_mark("underline", text)
        end
        if node["italic"]
            text = options.render_mark("italic", text)
        end
        if node["bold"]
            text = options.render_mark("bold", text)
        end
        text
    end

    private_class_method def self.render_string(string, options) 
        xml_doc = Nokogiri::HTML(appendFrame(string))
        result = xml_doc.xpath('//documentfragmentcontainer').inner_html
        findEmbeddedObject(xml_doc).each do |metadata|
            object = findObject(metadata, options.entry)
            replaceString = ''
            if object!= nil && object.length() > 0 
                replaceString = options.render_option(object[0], metadata)
            end
            result = result.sub(metadata.element.to_html, replaceString)
        end
        result
    end

    private_class_method def self.findEmbeddedObject(doc)
        metadataArray = []
        doc.xpath('//*[contains(@class, "embedded-asset") or contains(@class, "embedded-entry")]').each do |n|
            metadataArray.push(Model::Metadata.new(n))
        end
        metadataArray
    end

    private_class_method def self.findObject(metadata, entry) 
        if entry.has_key? '_embedded_items'
            embedItems = entry['_embedded_items']
            keys = embedItems.keys
            keys.each do |key|
                object = embedItems[key].select { |embedObject| embedObject['uid'] == metadata.item_uid }
                if object != nil && object.length() > 0 
                    return object 
                end
            end
        end
        return nil
    end

    module GQL
        include ContentstackUtils
        def self.json_to_html(content, options)
            embeddedItems = []
            if content.has_key? 'embedded_itemsConnection'
                embeddedItems = content['embedded_itemsConnection']['edges'] || []
            end            
            reference = -> (metadata){
                result = ""
                if embeddedItems != nil
                    object = embeddedItems.select { |embedObject| embedObject['node']["system"]["uid"] == metadata.item_uid }
                    if object != nil && object.length() > 0 
                        result = options.render_option(object[0]["node"], metadata)
                    end
                end
                result
            }         
           
            if content.has_key? 'json'
                json = content['json']
                if (json.instance_of? Array)
                    result = []
                    json.each do |n|
                        result.push(ContentstackUtils.json_doc_to_html(n, options, reference))
                    end
                    result
                elsif json.instance_of? Hash
                    ContentstackUtils.json_doc_to_html(json, options, reference)
                end
            end
        end
    end
end

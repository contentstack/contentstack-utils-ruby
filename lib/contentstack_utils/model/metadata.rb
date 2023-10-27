
module ContentstackUtils
    module Model
        class Metadata
            def initialize( element )
                if element.instance_of? Nokogiri::XML::Element
                    @itemType = element.attribute('type') ? element.attribute('type').value : nil
                    @styleType = element.attribute('sys-style-type') ? element.attribute('sys-style-type').value : nil
                    @itemUid ||= (element.attribute('data-sys-entry-uid') ? element.attribute('data-sys-entry-uid').value : nil) || (element.attribute('data-sys-asset-uid') ? element.attribute('data-sys-asset-uid').value : nil)
                    @contentTypeUid = element.attribute('data-sys-content-type-uid') ? element.attribute('data-sys-content-type-uid').value : nil
                    @text = element.text
                    @element = element
                    @attributes = element
                else
                    @itemType = element["attrs"]['type']
                    @styleType = element["attrs"]['display-type']
                    @itemUid ||= element["attrs"]['entry-uid'] || element["attrs"]['asset-uid']
                    @contentTypeUid = element["attrs"]['content-type-uid']
                    if element["children"] && element["children"].length() > 0
                        child = element["children"]
                        @text = ""
                        for item in child do
                            if item["type"] == nil && item["text"]
                                @text += item["text"]
                            end
                        end
                    end
                    @element = element
                    @attributes = element["attrs"]
                end
            end

            def item_type
                @itemType ? @itemType : nil
            end

            def style_type
                @styleType ? @styleType : nil
            end

            def item_uid
                @itemUid ? @itemUid : nil
            end

            def content_type_uid
                @contentTypeUid ? @contentTypeUid : nil
            end

            def text
                @text
            end

            def element
                @element
            end

            def attributes
                @attributes
            end

            def get_attribute_value(string)
                if @attributes.instance_of? Nokogiri::XML::Element
                    @attributes.attribute(string) ? @attributes.attribute(string).value : nil
                else
                    @attributes[string]
                end
            end
        end
    end
end

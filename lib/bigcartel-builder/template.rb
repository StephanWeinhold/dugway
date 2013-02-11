module BigCartel
  module Builder
    class Template
      def initialize(theme, name, content, liquify=true)
        @theme = theme
        @name = name
        @content = content
        @liquify = liquify
      end
      
      def content_type
        Rack::Mime.mime_type(File.extname(@name))
      end
      
      def render(store, request)
        if liquify?
          liquifier = Liquifier.new(@theme, store, request)
          rendered_content = liquifier.render @content
          
          if standalone?
            rendered_content
          else
            liquifier.render @theme.layout, 'page_content' => rendered_content
          end
        else
          @content
        end
      end
      
      def liquify?
        @liquify
      end
      
      def standalone?
        !@name.include?('.html') || @content =~ /\{\{\s*head_content\s*\}\}/
      end
    end
  end
end

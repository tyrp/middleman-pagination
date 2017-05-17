module Middleman
  module Pagination
    class IndexPage

      attr_reader :extension_context, :first_index, :pageable_context, :page_num, :symbolic_replacement_path, :index_locals, :index_options

      def initialize(extension_context, first_index, pageable_context, page_num, symbolic_replacement_path, index_locals, index_options)
        @extension_context = extension_context
        @first_index = first_index
        @pageable_context = pageable_context
        @page_num = page_num
        @symbolic_replacement_path = symbolic_replacement_path
        @index_locals = index_locals
        @index_options = index_options
      end

      def resource
        res = ::Middleman::Sitemap::Resource.new(sitemap, path, source_file)
        res.add_metadata(metadata)
        res
      end

      private

      def source_file
        first_index.source_file
      end

      def sitemap
        extension_context.sitemap
      end

      def path
        IndexPath.new(extension_context, first_index.path, page_num, symbolic_replacement_path).to_s
      end

      def metadata
        { locals: locals, options: index_options }
      end

      def locals
        index_locals.merge({ pagination_context: in_page_context })
      end

      def in_page_context
        InPageContext.new(pageable_context: pageable_context, page_num: page_num)
      end

    end
  end
end

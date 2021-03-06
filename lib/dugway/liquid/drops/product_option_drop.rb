module Dugway
  module Drops
    class ProductOptionDrop < BaseDrop
      def default
        position == 1
      end

      def has_custom_price
        price != product.default_price
      end

      # Make up inventory numbers since we obviously don't want that from the API

      def quantity
        @quantity ||= sold_out ? 0 : rand(100)
      end

      def sold
        @sold ||= rand(100)
      end

      def inventory
        ((quantity.to_f / (quantity + sold).to_f) * 100).round
      end

      def option_group_values
        @option_group_values ||= source['option_group_values'].present? ?
          source['option_group_values'].map { |value| OptionGroupValueDrop.new(value) } : []
      end
    end
  end
end

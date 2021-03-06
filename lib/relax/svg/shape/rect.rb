# frozen_string_literal: true

module Relax
  module SVG
    module Shape
      # Rectangle object as defined by
      # https://www.w3.org/TR/SVG2/shapes.html#RectElement
      class Rect < ShapePrototype
        NAME = 'rect'
        GEOMETRY_ATTRIBUTES = %i[x y width height rx ry].freeze
        ATTRIBUTES = (
          GEOMETRY_ATTRIBUTES +
          Relax::SVG::Shape::ATTRIBUTES
        ).freeze

        attr_accessor(*ATTRIBUTES)
      end
    end
  end
end

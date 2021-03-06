# frozen_string_literal: true

module Relax
  module SVG
    # Common methods for adding children to a
    # conatainer or to an image
    module Children
      ChildrenMustBeRendered = Relax::Errors::SVG::ChildrenMustBeRendered

      def add_children(children = [])
        raise Relax::Errors::SVG::MustBeAnArray unless children.is_a? Array

        yield children if block_given?
        map(children)
        self
      end

      private

      def map(children)
        children.map! do |child|
          if child.is_a? String
            child
          else
            child.render
          end
        end
        feed(children)
      end

      def feed(children)
        children.each do |value|
          instance_variable_set "@children_#{unique_id}", value
        end
        # children.each_with_index do |value, i|
        #   # instance_variable_set "@children_#{i}", value
        # end
      end

      def unique_id
        Process.clock_gettime(Process::CLOCK_MONOTONIC).to_s.delete('.')
      end

      # Returns the instance variables generated
      # by calling add_children
      # to_instance_var is a patch on Symbol class
      def children_names
        instance_variables - self.class::ATTRIBUTES.map(&:to_instance_var)
      end

      # To-do: raise an error when children is not
      # an svg element, currently it is possible
      # to add just a String as element
      def children_values
        children_names.map do |method_name|
          value = instance_eval(method_name.to_s)
          raise ChildrenMustBeRendered unless value.is_a? String

          value
        end.join
      end
    end
  end
end

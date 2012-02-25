# encoding: utf-8
module Dynamoid #:nodoc:

  # The HasMany association.
  module Associations
    class HasMany
      include Dynamoid::Associations::Association

      private

      def target_association
        key_name = source.class.to_s.singularize.downcase.to_sym
        guess = target_class.associations[key_name]
        return nil if guess.nil? || guess[:type] != :belongs_to
        key_name
      end
            
      def associate_target(object)
        object.update_attribute(target_attribute, Set[source.id])
      end
      
      def disassociate_target(object)
        object.update_attribute(target_attribute, nil)
      end
      
    end
  end
  
end
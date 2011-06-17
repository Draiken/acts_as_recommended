module ActsAsRecommended
  module ModelExtensions

    def self.included(base)
      # :nodoc:
      base.extend(ClassMethods)  
    end

    module ClassMethods

      def acts_as_recommended(*args)
        return if self.included_modules.include?(ActsAsRecommended::ModelExtensions::ActsAsRecommendedMethods)
        send :include, ActsAsRecommended::ModelExtensions::ActsAsRecommendedMethods
      end

    end

    # Métodos utilizados para incrementar e decrementar os contadores
    # de contribuição.
    #
    module ActsAsRecommendedMethods

      def recommend!(recommendation, owner)
        raise "Recommendation cannot be nil" if recommendation.nil?

        # either a 1/0 or a true/false
        recommendation = _normalize_recommendation(recommendation)

        # find last recomendation of this item 
        # from this user or create a new one
        new_recommendation = _new_or_last_recommendation_for(owner)
        new_record = new_recommendation.new_record?

        # return if it's the same recommendation as before
        ( new_recommendation.touch and return true ) if ( not new_record and new_recommendation.recommendation == recommendation )

        old_recommendation = new_recommendation.recommendation unless new_record

        new_recommendation.recommendation = recommendation
        new_recommendation.save

        # adds the recommendation count to self if needed
        self.good_recommendations += 1 if recommendation
        self.bad_recommendations  += 1 if not recommendation

        # removes the old recomendation count if you are changing an old one
        unless new_record
          self.bad_recommendations  -= 1 if recommendation  && ( not old_recommendation )
          self.good_recommendations -= 1 if !recommendation && old_recommendation
        end

        self.save
      end

      def recommendations
        self.good_recommendations - self.bad_recommendations
      end

      def recommendations_count
        self.good_recommendations + self.bad_recommendations
      end

      def good_recommendations_percent(format = '%.2f')
        format % ((self.good_recommendations.to_f / (self.recommendations_count == 0 ? 1.to_f : self.recommendations_count.to_f)) * 100)
      end

      def bad_recommendations_percent(format = '%.2f')
        format % ((self.bad_recommendations.to_f / (self.recommendations_count == 0 ? 1.to_f : self.recommendations_count.to_f)) * 100)
      end

      def recommended_by?(user)
        Recommendation.of_item(self).owned_by(user).first ? true : false
      end

      def get_recommendation_of(user)
        Recommendation.of_item(self).owned_by(user).first.recommendation
      end

      private

      def _normalize_recommendation(recommendation)
        (( recommendation.is_a?(String) || recommendation.is_a?(Fixnum) ) ? (recommendation.to_i == 1) : recommendation)
      end

      def _new_or_last_recommendation_for(owner)
        Recommendation.of_item(self).owned_by(owner).first or Recommendation.new(:owner_id => owner.id, :recommendable_id => self.id, :recommendable_type => self.class.base_class.name)
      end
    end
  end
end

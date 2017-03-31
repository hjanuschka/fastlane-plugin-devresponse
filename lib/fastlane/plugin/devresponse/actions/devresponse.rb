module Fastlane
  module Actions
    class DevresponseAction < Action
      def self.run(params)
      end

      def self.description
        "Devresponse patcher"
      end

      def self.available_options
        [
        ]
      end

      def self.authors
        ["hjanuschka"]
      end

      def self.is_supported?(platform)
        true
      end
    end
  end
end

require "branch_io_cli"
include BranchIOCLI::Format::HighlineFormat

module Fastlane
  module Actions
    class ValidateUniversalLinksAction < Action
      def self.run(params)
        config = BranchIOCLI::Configuration::ValidateConfiguration.wrapper params, false
        BranchIOCLI::Commands::ValidateCommand.new(config).run! == 0
      rescue StandardError => e
        UI.user_error! "Error in ValidateUniversalLinksAction: #{e.message}\n#{e.backtrace}"
        false
      end

      def self.description
        "Validates Universal Link configuration for an Xcode project."
      end

      def self.authors
        [
          "Branch <integrations@branch.io>",
          "Jimmy Dee <jgvdthree@gmail.com>"
        ]
      end

      def self.details
        render :validate_description
      end

      def self.example_code
        [
          <<-EOF
            validate_universal_links
          EOF,
          <<-EOF
            validate_universal_links(xcodeproj: "MyProject.xcodeproj")
          EOF,
          <<-EOF
            validate_universal_links(xcodeproj: "MyProject.xcodeproj", target: "MyProject")
          EOF,
          <<-EOF
            validate_universal_links(domains: %w{example.com www.example.com})
          EOF
        ]
      end

      def self.available_options
        BranchIOCLI::Configuration::ValidateConfiguration.available_options.map do |option|
          FastlaneCore::ConfigItem.from_branch_option(option)
        end
      end

      def self.return_value
        BranchIOCLI::Configuration::ValidateConfiguration.return_value
      end

      def self.is_supported?(platform)
        platform == :ios
      end

      def self.category
        :project
      end
    end
  end
end

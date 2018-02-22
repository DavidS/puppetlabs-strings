require_relative 'puppet_class'

module PuppetStrings::Markdown
  module PuppetClasses

    # @return [Array] list of classes
    def self.in_classes
      YARD::Registry.all(:puppet_class).sort_by!(&:name).map!(&:to_hash)
    end

    def self.render
      final = in_classes.length > 0 ? "## Classes\n\n" : ""
      in_classes.each do |klass|
        to_render = PuppetStrings::Markdown::PuppetClass.new(klass)
        final << to_render.render if to_render.contains_displayed_tags?
      end
      final
    end

    def self.toc_info
      final = []

      in_classes.each do |klass|
        final.push(PuppetStrings::Markdown::PuppetClass.new(klass).toc_info)
      end

      final
    end
  end
end

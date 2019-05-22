require 'onlyoffice_file_helper'
require_relative 'document_builder_api_common/class_name_helper'
module TestingApiOnlyfficeCom
  # https://user-images.githubusercontent.com/40513035/57924882-0e894d80-78af-11e9-9ce3-d3f5eb9a2b23.png
  # /docbuilder/basic
  class DocumentationMethodPage
    attr_reader :link, :page, :params_exist, :return_exist, :example_exist, :document_exist, :path

    def initialize(editor, current_class, method)
      @link = "#{Config.new.server}/docbuilder/#{ClassNameHelper.cleanup_name(editor)}/#{ClassNameHelper.cleanup_name(current_class)}/#{ClassNameHelper.cleanup_name(method)}"
      @page = Nokogiri::HTML(URI.parse(@link).open)
      @path = "#{editor}/#{current_class}/#{method}"
      @params_exist ||= !@page.xpath('//*[@class="table"]').empty?
      @return_exist ||= !@page.xpath('//*[@class="param-type"]').empty?
      @example_exist ||= !@page.xpath('//pre').empty?
      @document_exist ||= !@page.xpath('//*[@class="docbuilder_resulting_docs"]').empty?
    end
  end
end

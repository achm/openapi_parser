# TODO: info object
# TODO: servers object
# TODO: tags object
# TODO: externalDocs object

module OpenAPIParser::Schemas
  class OpenAPI < Base
    def initialize(raw_schema, config)
      super('#', nil, self, raw_schema)
      @find_object_cache = {}
      @path_item_finder = OpenAPIParser::PathItemFinder.new(paths) if paths # invalid definition
      @config = config
    end

    # @!attribute [r] openapi
    #   @return [String, nil]
    openapi_attr_values :openapi

    # @!attribute [r] paths
    #   @return [Paths, nil]
    openapi_attr_object :paths, Paths, reference: false

    # @!attribute [r] components
    #   @return [Components, nil]
    openapi_attr_object :components, Components, reference: false

    # @return [OpenAPIParser::RequestOperation, nil]
    def request_operation(http_method, request_path)
      OpenAPIParser::RequestOperation.create(http_method, request_path, @path_item_finder, @config)
    end
  end
end

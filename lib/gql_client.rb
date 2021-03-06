require "gql_client/version"
require 'uri'
require 'net/http'
require 'json'


module GqlClient
  def self.execute(url, query, headers, variables = {})
    url = URI(url)
    http = Net::HTTP.new(url.host, url.port)

    request = Net::HTTP::Post.new(url, headers)
    request["cookie"] = 'request_method=POST'
    request["content-type"] = 'application/json'

    body = {
      "query": query,
      "variables": variables
    }

    request.body = body.to_json

    response = http.request(request)
    response.code == "200" ? JSON.parse(response.read_body) : response.read_body
  end

  class Session
    
    attr_accessor :request
    attr_accessor :http

    INTROSPECTION_QUERY_FILE = "introspection_query.graphql"

    def initialize(url, headers)
      url = URI(url)
      @http = Net::HTTP.new(url.host, url.port)

      @request = Net::HTTP::Post.new(url, headers)
      @request["cookie"] = 'request_method=POST'
      @request["content-type"] = 'application/json'
    end

    def schema
      @schema ||= begin
        request.body = {"query": introspection_query }.to_json
        response = http.request(request)
        raise StandardError, "Introspection Query Failed" unless response.code == "200"
        JSON.parse(response.read_body)
      end
    end

    def introspection_query
      File.read(INTROSPECTION_QUERY_FILE)
    end 

    def execute(query, variables = {})
      body = {
        "query": query,
        "variables": variables
      }
  
      request.body = body.to_json
  
      response = http.request(request)
      response.code == "200" ? JSON.parse(response.read_body) : response.read_body
    end
  end

end
module Pinata
  api_key = nil
  secret_api_key = nil

  class Pin
    Endpoint = "https://api.pinata.cloud/pinning/"

    def self.pin_file(filename)
      uri = URI.parse(Pin::Endpoint + "pinFileToIPFS")
      boundary = "AaB03x"
      post_body = []
      # Add the file Data
      post_body << "--#{boundary}\r\n"
      post_body << "Content-Disposition: form-data; name=\"file\"; filename=\"#{File.basename(filename)}\"\r\n"
      post_body << "Content-Type: #{MIME::Types.type_for(filename)}\r\n\r\n"
      post_body << File.read(filename)
      post_body << "\r\n\r\n--#{boundary}--\r\n"


      # Create the HTTP objects
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      request = Net::HTTP::Post.new(uri.request_uri)
      request['content-type'] = "multipart/form-data; boundary=#{boundary}"
      request['pinata_api_key'] = Pinata.api_key
      request['pinata_secret_api_key'] = Pinata.secret_api_key
      request.body = post_body.join

      puts request.body
      # Send the request
      response = http.request(request)

      return JSON.parse(response.body)
    end

    def self.remove_pin(hash)
      uri = URI.parse(Pin::Endpoint + "removePinFromIPFS")
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      request = Net::HTTP::Post.new(uri.request_uri)
      request['content-type'] = "application/json"
      request['pinata_api_key'] = Pinata.api_key
      request['pinata_secret_api_key'] = Pinata.secret_api_key
      request.body = "{
        \"ipfs_pin_hash\" : \"#{hash}\"
      }"
      response = http.request(request)

      if response.is_a?(Net::HTTPSuccess)
        puts "Success"
      else
        return JSON.parse(response.body)
      end
    end
  end
end

class YelpClient: BDBOAuth1RequestOperationManager {

    var accessToken: String!
    var accessSecret: String!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(consumerKey key: String!, consumerSecret secret: String!, accessToken: String!, accessSecret: String!) {
        self.accessToken = accessToken
        self.accessSecret = accessSecret
        var baseUrl = NSURL(string: "http://api.yelp.com/v2/")
        super.init(baseURL: baseUrl, consumerKey: key, consumerSecret: secret);
        
        var token = BDBOAuthToken(token: accessToken, secret: accessSecret, expiration: nil)
        self.requestSerializer.saveAccessToken(token)
    }
    
    func searchWithTerm(term: String, parameters: [NSString: String]? = nil, offset: Int = 0, limit: Int = 20, success: (AFHTTPRequestOperation!, AnyObject!) -> Void, failure: (AFHTTPRequestOperation!, NSError!) -> Void) -> AFHTTPRequestOperation! {
        var params: [NSString: AnyObject] = [
            "term": term,
            "offset": offset,
            "limit": limit,
            "ll": "37.367092899999996,-122.08550210000001"
        ]
        for (key, value) in parameters! {
            params[key] = value
        }
        println("searching...")
        println(params)
        return self.GET("search", parameters: params, success: success, failure: failure)
    }
    
}
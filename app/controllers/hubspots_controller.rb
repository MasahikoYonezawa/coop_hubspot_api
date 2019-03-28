class HubspotsController < ApplicationController
  require 'net/http'
  require 'uri'
  require 'json'

  def cooperation
    @contacts = Hubspot::Contact.all
    @contact_properties = {}
    i = 0
    @contacts.each do |c|
      @contact_properties[i] = Hubspot::Contact.find_by_id(c.vid).properties
      i = i + 1
    end
    @contact_properties_json = @contact_properties.to_json
    @contact_properties.each do |cp_key, cp_val|
      data = {
        "item_code" => "ACCOUNT-CONNECT-CODE-HERE",
        "line_id" => "U422fbfc986dfc2c37e5466c3d7c0844e",
        "item_name" => "メールテスト",
        "member_meta" => [ cp_val ]
      }.to_json
      p data
    end
    
  end
  
  def post_contact_properties
    
    droplet_ep = 'https://yourdomain.example.com/outerapi/v1/call'
    # token = '(トークン)'
    
    uri = URI.parse(droplet_ep)
    # http = Net::HTTP.new(uri.host, uri.port)
    
    # http.use_ssl = true
    # http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    
    # req = Net::HTTP::Post.new(uri.request_uri)
    req = Net::HTTP::Post.new(uri)
    # req["Authorization"] = "bearer #{token}"
    req["Content-Type"] = "application/json"
    
    @contacts = Hubspot::Contact.all
    @contact_properties = {}
    i = 0
    @contacts.each do |c|
      @contact_properties[i] = Hubspot::Contact.find_by_id(c.vid).properties
      i = i + 1
    end
    # @contact_properties_json = @contact_properties.to_json
    data = {}.to_json
    @contact_properties.each do |cp_key, cp_val|
      if cp_val["line_uid"] == params[:line_uid] 
        # && cp_val["item_code"] == params[:item_code]
        data = {
          "item_code" => "ACCOUNT-CONNECT-CODE-HERE",
          "line_id" => "U422fbfc986dfc2c37e5466c3d7c0844e",
          "item_name" => "メールテスト",
          "member_meta" => [ cp_val ]
        }.to_json
        break
        #     {
        #       "name": "firstname",
        #       "value": cp_val["firstname"]
        #     },
        #     {
        #       "name": "city",
        #       "value": cp_val["city"]
        #     },
        #     {
        #       "name": "num_unique_conversion_events",
        #       "value": cp_val["num_unique_conversion_events"]
        #     },
        #     {
        #       "name": "hs_email_quarantined",
        #       "value": cp_val["hs_email_quarantined"]
        #     },
        #     {
        #       "name": "hs_analytics_revenue",
        #       "value": cp_val["hs_analytics_revenue"]
        #     },
        #     {
        #       "name": "hs_social_num_broadcast_clicks",
        #       "value": cp_val["hs_social_num_broadcast_clicks"]
        #     },
        #     {
        #       "name": "createdate",
        #       "value": cp_val["createdate"]
        #     },
        #     {
        #       "name": "hs_email_recipient_fatigue_recovery_time",
        #       "value": cp_val["hs_email_recipient_fatigue_recovery_time"]
        #     },
        #     {
        #       "name": "hs_email_optout",
        #       "value": cp_val["hs_email_optout"]
        #     },
        #     {
        #       "name": "hs_analytics_last_timestamp",
        #       "value": cp_val["hs_analytics_last_timestamp"]
        #     },
        #     {
        #       "name": "hs_social_linkedin_clicks",
        #       "value": cp_val["hs_social_linkedin_clicks"]
        #     },
        #     {
        #       "name": "hs_analytics_last_visit_timestamp",
        #       "value": cp_val["hs_analytics_last_visit_timestamp"]
        #     },
        #     {
        #       "name": "hs_social_last_engagement",
        #       "value": cp_val["hs_social_last_engagement"]
        #     },
        #     {
        #       "name": "hs_analytics_source",
        #       "value": cp_val["hs_analytics_source"]
        #     },
        #     {
        #       "name": "hs_email_domain",
        #       "value": cp_val["hs_email_domain"]
        #     },
        #     {
        #       "name": "hs_analytics_num_page_views",
        #       "value": cp_val["hs_analytics_num_page_views"]
        #     },
        #     {
        #       "name": "hs_analytics_first_touch_converting_campaign",
        #       "value": cp_val["hs_analytics_first_touch_converting_campaign"]
        #     },
        #     {
        #       "name": "hs_email_optout_6290544",
        #       "value": cp_val["hs_email_optout_6290544"]
        #     },
        #     {
        #       "name": "company",
        #       "value": cp_val["company"]
        #     },
        #     {
        #       "name": "state",
        #       "value": cp_val["state"]
        #     },
        #     {
        #       "name": "email",
        #       "value": cp_val["email"]
        #     },
        #     {
        #       "name": "website",
        #       "value": cp_val["website"]
        #     },
        #     {
        #       "name": "jobtitle",
        #       "value": cp_val["jobtitle"]
        #     },
        #     {
        #       "name": "hs_analytics_first_visit_timestamp",
        #       "value": cp_val["hs_analytics_first_visit_timestamp"]
        #     },
        #     {
        #       "name": "lastmodifieddate",
        #       "value": cp_val["lastmodifieddate"]
        #     },
        #     {
        #       "name": "hs_analytics_first_timestamp",
        #       "value": cp_val["hs_analytics_first_timestamp"]
        #     },
        #     {
        #       "name": "hs_social_google_plus_clicks",
        #       "value": cp_val["hs_social_google_plus_clicks"]
        #     },
        #     {
        #       "name": "hs_analytics_last_touch_converting_campaign",
        #       "value": cp_val["hs_analytics_last_touch_converting_campaign"]
        #     },
        #     {
        #       "name": "hs_analytics_average_page_views",
        #       "value": cp_val["hs_analytics_average_page_views"]
        #     },
        #     {
        #       "name": "lastname",
        #       "value": cp_val["lastname"]
        #     },
        #     {
        #       "name": "hs_social_facebook_clicks",
        #       "value": cp_val["hs_social_facebook_clicks"]
        #     },
        #     {
        #       "name": "hs_predictivecontactscore_v2",
        #       "value": cp_val["hs_predictivecontactscore_v2"]
        #     },
        #     {
        #       "name": "num_conversion_events",
        #       "value": cp_val["num_conversion_events"]
        #     },
        #     {
        #       "name": "hs_email_optout_6290511",
        #       "value": cp_val["hs_email_optout_6290511"]
        #     },
        #     {
        #       "name": "hs_analytics_num_event_completions",
        #       "value": cp_val["hs_analytics_num_event_completions"]
        #     },
        #     {
        #       "name": "hs_social_twitter_clicks",
        #       "value": cp_val["hs_social_twitter_clicks"]
        #     },
        #     {
        #       "name": "hs_analytics_source_data_2",
        #       "value": cp_val["hs_analytics_source_data_2"]
        #     },
        #     {
        #       "name": "hs_lifecyclestage_lead_date",
        #       "value": cp_val["hs_lifecyclestage_lead_date"]
        #     },
        #     {
        #       "name": "hs_analytics_source_data_1",
        #       "value": cp_val["hs_analytics_source_data_1"]
        #     },
        #     {
        #       "name": "lifecyclestage",
        #       "value": cp_val["lifecyclestage"]
        #     }
        #   ]
        # }.to_json
      # elsif cp_val["member_id"] == params[:member_id]
      #   data = {
      #     "item_code": "ACCOUNT-CONNECT-CODE-HERE",
      #     "line_id": "U422fbfc986dfc2c37e5466c3d7c0844e",
      #     "item_name": "メールテスト",
      #     "member_meta": [ cp_val ]
      #   }.to_json
      #   break
        #     {
        #     "name": "メールアドレス",
        #     "value": "test@example.com"
        #     },
        #     {
        #     "name": "電話番号",
        #     "value": "000000"
        #     },
        #     {
        #     "name": "何からしらの項目名",
        #     "value": "何かしらの値"
        #     }
        #   ]
        # }.to_json
      end
    end
        
    
    
    req.body = data
    res = http.request(req)
    
    puts res.code, res.msg, res.body
  end
end

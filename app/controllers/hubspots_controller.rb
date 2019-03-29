class HubspotsController < ApplicationController
  require 'net/https'
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
  end
  
  def show_contact_properties
    p params[:line_uid]
    @contacts = Hubspot::Contact.all
    @contact_properties = {}
    i = 0
    @contacts.each do |c|
      @contact_properties[i] = Hubspot::Contact.find_by_id(c.vid).properties
      i = i + 1
    end
    
    @contact_properties.each do |cp_key, cp_val|
      if cp_val["line_uid"] == params[:line_uid] && cp_val["item_code"] == params[:item_code]
        @results = cp_val
        break
      elsif cp_val["member_id"] == params[:member_id]
        @results = cp_val
        break
      else
        @results = "データ無し"
      end
    end
  end
  
  # HubSpotの任意のコンタクト情報を返すAPI
  def get_contact_properties
    # HubSpotからデータ取得
    @contacts = Hubspot::Contact.all
    @contact_properties = {}
    i = 0
    @contacts.each do |c|
      @contact_properties[i] = Hubspot::Contact.find_by_id(c.vid).properties
      i = i + 1
    end
    
    item_code = ""
    line_id = ""
    member_id = ""
    data = []
    
    # 条件に合致するデータをセット
    @contact_properties.each do |cp_key, cp_val|
      if cp_val["line_uid"] == params[:line_uid] && cp_val["item_code"] == params[:item_code]
        item_code = cp_val["item_code"]
        line_id = cp_val["line_uid"]
        cp_val.each do |key, val|
          column = { name: key, value: val }
          data.push(column)
        end
        break
      elsif cp_val["member_id"] == params[:member_id]
        member_id = cp_val["member_id"]
        cp_val.each do |key, val|
          column = { name: key, value: val }
          data.push(column)
        end
        break
      end
    end
    
    # jsonで返す
    if data.blank?
      render json: {status: 'ERROR', data: "No matching data"}
    else
      if member_id.blank?
        render json: {item_code: item_code, line_id: line_id, member_meta: data}
      else
        render json: {member_id: member_id, member_meta: data}
      end
    end
    
  end
  
end

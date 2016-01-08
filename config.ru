require "sinatra"

class App < Sinatra::Base

  # NOTE: Values below are just dummy data and it might not work with dragonpay when you clone this
  # this is just a basic template as my refresher on how to make the direct post work.
  get "/" do
    @merchant_id      = ENV.fetch("DRAGONPAY_MERCHANT_ID", "123")
    @secret_key       = ENV.fetch("DRAGONPAY_SECRET_KEY", "s3cr3tk3y")

    @txnid       = "1234567890"
    @description = "Payment of Php 100.00 from Test"
    @currency    = "PHP"
    @email       = "test@example.com"
    @amount      = "100"
    @digest      = "d1gest3dparamt3rs"

    erb :form
  end

  post "/order" do
    @test_gateway_url = ENV.fetch("DRAGONPAY_TEST_GATEWAY_URL", "http://test.dragonpay.ph")
    @live_gateway_url = ENV.fetch("DRAGONPAY_LIVE_GATEWAY_URL", "https://gw.dragonpay.ph")

    url = %Q{
      #{@test_gateway_url}/Pay.aspx?
      merchantid = #{params[:merchant_id]}&
      txnid = #{params[:txnid]}&
      amount = #{params[:amount]}&
      ccy = #{params[:ccy]}&
      description = #{params[:description]}&
      email = #{params[:email]}&
      digest = #{params[:digest]}
    }.split.join

    redirect url
  end

  # NOTE: This callback url is configured in Dragonpay side
  post "/test1" do
    # Redirect somewhere (e.g summary page)
  end

  # NOTE: This callback url is configured in Dragonpay side
  post "/test2" do
    # Update order to paid success, failed, etc...
  end

end

run App

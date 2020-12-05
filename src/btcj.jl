module btcj

using HTTP
using JSON

token = Dict(
    "apikey" => "YOUR_WML_APIKEY",
    "grant_type" => "urn:ibm:params:oauth:grant-type:apikey"
)

request_token = HTTP.request("POST", "https://iam.cloud.ibm.com/identity/token",
    ["Content-Type" => "application/x-www-form-urlencoded"],
    HTTP.URIs.escapeuri(token))

access_token = JSON.parse(String(request_token.body))

submission = Dict(
    "email_addr" => "YOUR_EMAIL_HERE",
    "wml_url" => "WML_URL",
    "iam_token" => access_token["access_token"],
    "submit_confirmation" => false
)

submit = HTTP.request("POST", "http://172.21.86.186:5000/submit",
    ["Content-Type" => "application/json"],
    JSON.json(submission))

println(String(submit.body))

end # module

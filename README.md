# waltz-SDK-example

git clone https://github.com/WaltzApp/waltz-SDK-example

# OAuth

The OAuth flow is based on this architecture.<p align="center">
  <img src="./oauth.png" width="400" title="Architecture OAuth">
</p>

To have the SDK implementation fetch the JWT, consult the plateform specific documentation under its architecture folder (iOS or Android). For backend validation of the 'secret', please use this endpoint, described below.

GET https://re.waltzlabs.com/mobile/v1/mobileapp/getSecret <p align="center">
  <img src="./endpoint.png" width="800" title="Architecture OAuth">
</p>

This is the expected response: <p align="center">
  <img src="./response.png" width="400" title="Architecture OAuth">
</p>
